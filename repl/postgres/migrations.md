# Migrations

Database migrations provide a way to have a no-downtime database, but there is a process cost.

In general, you have a dependency relationship with a provider and consumer and basic rules are but always think it out.

- Add: Do on provider first
- Delete: Do on consumer first. 
- Move/Rename: Basically, an Add, then Delete

Note, sometimes the provider runs something based on values of the consumer in which the consumer becomes the source (they can have a two-way relationship)
Often, where app code is specifying something in database.

- Triggers: if app code is specifying triggers then you need to delete the trigger first before the app code is pushed.
- See [Always use constraint tables](#always-use-constraint-tables)
- ORM: Sometimes the ORM will still be looking at an enum for a mapping in which the dependency relationship needs to be thought out.

### DML Migrations

These are usually when the code refers to data in the database such as configs.
It is possible to do this with 
- Migrations
- In the app code where you can reference two changing names (but you need to delete the code in the following release)
- Admin (do it manually)

**With migrations**

*pre*
```sql
INSERT INTO translations (name, translation, type)
  SELECT 'KEY_NEW', translation, type
    FROM translations
    WHERE name = 'KEY_OLD';
```

*post*
```sql
DELETE FROM translations WHERE name = 'KEY_OLD';
```

It is also possible to do this in app code where you use a different *get* method to handle both,
then return to the original *get* method in the next release.

**With Code**

When the copying of data is complex, the code approach can work because it
knows what to access (or what exists) but requires code changes in consecutive
releases. That is, in the app code `if (old config exists) use it else use new
config`.

post

```sql
UPDATE configuration SET name = 'new_config_name' WHERE config_name = 'old_config_name';
```

This is very targeted though as you have to know/hard code the old and new name in the app code, then change back in the following release.


### Always use constraint tables

If you always have a constraint table updating constraints follow the same rules (Add, Delete, Move).
But if you use hardcoded constraints like the following you would have to update the database(source) first on a Delete.

```sql
CONSTRAINT xxx_check CHECK ((field_name = ANY (ARRAY['OPT1'::text, 'OPT2'::text]))),
```

Updating this constraint is harder (could use a migration time annotation) than add/remove data from the constraint table.
Better to have.

```sql
CREATE TABLE child_table (
  child_table_id int PRIMARY KEY,
  ...
);

INSERT INTO child_table (name) VALUES ('OPT1');
INSERT INTO child_table (name) VALUES ('OPT2');

CREATE TABLE root_table (
  ...
  child_table_id int REFERENCES child_table,
  ...
);
```

### Explicit locking when using ALTER TABLE

The *ALTER TABLE* statement acquires an *ACCESS EXCLUSIVE* lock against the
relation it's modifying.  This lock model conflicts with all other lock types,
meaning an *ALTER TABLE* will block until all other queries against a relation
are complete, whether t<F8>y are read-only, or write queries. Because locks are
grandet in the order they are requested, this also means that all subsequent
queries will block until the *ALTER TABLE* statement completes.

Consider,

1. Complicated report query against my_table
2. ALTER TABLE my_table ADD COLUMN foo text;
3. SELECT * FROM my_table;

2. will block until 1. completes because it needs the *ACCESS EXCLUSIVE* lock.
And, because locks are granted in the order of request, 3. will also be blocked.

The solution is to manualy aquire the lock with *LOCK TABLE my_table IN ACCESS EXCLUSIVE MODE NOWAIT*.
If it gets and error (cannot acquire immediately), retry (need to do this in migration app code)

It only makes sense to use @LockTables for short queries, like an ADD COLUMN
without default.  For long queries (e.g., ALTER TABLE ADD COLUMN ... DEFAULT
'foo', which updates the whole table with the default value), we need to use
other strategies to prevent locking (like incrementally updating the table).


```sql
--@LockTables some_table
CREATE TABLE my_table (
  ...
  some_id NOT NULL REFERENCES some_table (some_id),
  ...
);

### Basics

**Drop table**

post
```sql
--@LockTable
DROP TABLE IF EXISTS my_table;
```

**Drop column**

*Nullable*

post
```sql
--@LockTable
ALTER TABLE my_table DROP COLUMN IF EXISTS my_col;
```

*NOT NULL*

Need to protect when the new code creates null values.

pre
```sql
--@LockTable
ALTER TABLE my_table ALTER COLUMN my_col DROP NOT NULL;
```

post
```sql
--@LockTable
ALTER TABLE my_table DROP COLUMN IF EXISTS my_col;
```

**Add column**

Do not use this pattern with boolean, the NOT NULL DEFAULT pattern instead.

pre
```sql
--@LockTables
ALTER TABLE my_table ADD COLUMN my_col text;
```

**Add column NOT NULL DEFAULT**

3 pre migration to avoid locking the table and deadlock

pre (if multiple tables, this script can have them)
```sql
ALTER TABLE my_table
  ADD COLUMN is_something boolean,
  ALTER COLUMN is_something SET DEFAULT true;
```

pre (this script cannot have multiple tables, a new script for each table is required)
```sql
UPDATE my_table SET is_something = true;
```

pre (if multiple tables, this script can have them)
```sql
--@LockTables
ALTER TABLE my_table
  ALTER COLUMN is_something SET NOT NULL;
```

### Moving existing field to it's own table

Old code will reference old table. When crud happens on old it needs to be
replicated on the new table with a trigger. Note that it also deletes from
the new_table on each trigger to update because the old code and new code
need to update the table.

This doesn't handle delete!?

pre

```sql
--@LockTables room_contract
CREATE TABLE new_table
(
  ...
  migrated_field integer NOT NULL DEFAULT 1,
);

CREATE OR REPLACE FUNCTION move_stuff_function()
  RETURNS trigger AS $$
BEGIN -- Delete existing record in order to update values
  DELETE FROM new_table
  WHERE migrated_field = NEW.migrated_field;
  INSERT INTO new_table
    (..., migrated_field)
  VALUES
    (..., NEW.migrated_field);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER old_table_trigger
AFTER INSERT OR UPDATE ON old_table
FOR EACH ROW EXECUTE PROCEDURE move_stuff_function();
```

pre

```sql
-- Migrate existing data to new table
INSERT INTO new_table
(..., migrated_field)
  SELECT ..., migrated_field
  FROM old_table;
```

post

```sql
--@LockTables old_table
DROP TRIGGER IF EXISTS old_table_trigger ON old_table;
DROP FUNCTION IF EXISTS move_stuff_function();
ALTER TABLE old_table
  DROP COLUMN IF EXISTS migrated_field,
```

### Using ddl2rename

- execute ddl2rename script to local db that have been migrated to V1.
-
```bash
postgres@v121db.corp.ezrez:5432
qaone=# \a\t
Output format is unaligned.
Showing only tuples.

qaone=# SELECT ddl2rename('{{xout,blackout},{id,blackout_id},{xdate,blackout_date}}', 121);
NOTICE:  old_table_name = xout
NOTICE:  new_table_name = blackout
NOTICE:  old_column_names = {id,xdate}
NOTICE:  new_column_names = {blackout_id,blackout_date}
```

**Rename table and columns**

Old names (as view) accessed by V1
New names as table accessed by V2.

**Rename columns only**

Old names (as view) accessed by V1.
New names (as view) accessed by V2.
Shadow Table 

**Change column type**

In order to not lock the table we can't use `ALTER TYPE`, we need to manually
`UPDATE` the new column value and then do Rename table/column pattern.

*Add column*

pre
```sql
--@LockTables
ALTER TABLE my_table
  ADD COLUMN my_col TIMESTAMP WITHOUT TIME ZONE,
  ALTER COLUMN my_col SET DEFAULT now();
```

Get data from old column

pre
```sql
UPDATE my_table SET my_col = CAST(old_col) AS TIMESTAMP);
```

We need to populate while the current code is running and need an
Insert/update/delete script

It is important to remember to use INSTEAD OF on the trigger because if you are
using AFTER/BEFORE EACH ROW you will need to handle recursive triggers (as you
are updating the same table the trigger will fire itself each time)

pre

```sql
--@LockTables marketing_promotion
-- rename table
ALTER TABLE settings.marketing_promotion RENAME TO marketing_promotion_shadow;

-- create new view
CREATE VIEW marketing_promotion AS
 SELECT id
 , marketing_promotion_group_id
 , rank
 , title
 , image_url
 , description
 , include_lead_price
 , url_type
 , destination_landing_page_airport_code
 , destination_landing_page_search_key
 , hotel_landing_page_room_gds
 , hotel_landing_page_hotel_code
 , custom_landing_page_url
 , data_source
 , marketing_cache_search_parameters_set_id
 , marketing_cache_rank
 , promotion_end_timestamp
 , promotion_start_timestamp
 , promotion_end_date
 , promotion_start_date
 FROM marketing_promotion_shadow;

 ALTER VIEW marketing_promotion
 ALTER COLUMN id SET DEFAULT nextval('marketing_promotion_id_seq'::regclass),
 ALTER COLUMN rank SET DEFAULT 1,
 ALTER COLUMN include_lead_price SET DEFAULT false,
 ALTER COLUMN data_source SET DEFAULT 'MANUAL'::text,
 ALTER COLUMN promotion_start_timestamp SET DEFAULT ('now'::text)::TIMESTAMP,
 ALTER COLUMN promotion_start_date SET DEFAULT ('now'::text)::DATE;

-- remember the order of the new and old columns in the INSERT and UPDATE operations
 CREATE OR REPLACE FUNCTION insteadof_marketing_promotion_dml_fn()
 RETURNS TRIGGER
 LANGUAGE plpgsql
 AS $trigger$
 BEGIN
 IF TG_OP = 'INSERT' THEN
 INSERT INTO marketing_promotion_shadow
 ( id
 , marketing_promotion_group_id
 , rank
 , title
 , image_url
 , description
 , include_lead_price
 , url_type
 , destination_landing_page_airport_code
 , destination_landing_page_search_key
 , hotel_landing_page_room_gds
 , hotel_landing_page_hotel_code
 , custom_landing_page_url
 , data_source
 , marketing_cache_search_parameters_set_id
 , marketing_cache_rank
 , promotion_end_date        -- old column used in 151 code, this exists in 151, 151 pre and 152 pre
 , promotion_start_date      -- old column used in 151 code, this exists in 151, 151 pre and 152 pre
 , promotion_end_timestamp   -- new column used in 152 code, this exists on 151 pre, 152 pre and 152 post
 , promotion_start_timestamp -- new column used in 152 code, this exists on 151 pre, 152 pre and 152 post
 ) VALUES
 ( NEW.id
 , NEW.marketing_promotion_group_id
 , NEW.rank
 , NEW.title
 , NEW.image_url
 , NEW.description
 , NEW.include_lead_price
 , NEW.url_type
 , NEW.destination_landing_page_airport_code
 , NEW.destination_landing_page_search_key
 , NEW.hotel_landing_page_room_gds
 , NEW.hotel_landing_page_hotel_code
 , NEW.custom_landing_page_url
 , NEW.data_source
 , NEW.marketing_cache_search_parameters_set_id
 , NEW.marketing_cache_rank
 , NEW.promotion_end_date    -- we will always send old column
 , NEW.promotion_start_date, -- we will always send old column
 CASE
  WHEN current_setting('switchfly.release_version')::int < 1520000
  THEN
   CAST(NEW.promotion_end_date AS TIMESTAMP)   -- if code is 151, we send the old value converted to the new type or empty, whatever fits your need.
 ELSE
  NEW.promotion_end_timestamp                  -- if code is 152, we send the value from the app.
 END,
 CASE
  WHEN current_setting('switchfly.release_version')::int < 1520000
  THEN
   CAST(NEW.promotion_start_date AS TIMESTAMP) -- if code is 151, we send the old value converted to the new type or empty, whatever fits your need.
 ELSE
  NEW.promotion_start_timestamp                -- if code is 152, we send the value from the app.
 END

 );
 RETURN NEW;
 ELSIF TG_OP = 'UPDATE' THEN
 UPDATE marketing_promotion_shadow SET
 ( id, marketing_promotion_group_id
 , rank
 , title
 , image_url
 , description
 , include_lead_price
 , url_type
 , destination_landing_page_airport_code
 , destination_landing_page_search_key
 , hotel_landing_page_room_gds
 , hotel_landing_page_hotel_code
 , custom_landing_page_url
 , data_source
 , marketing_cache_search_parameters_set_id
 , marketing_cache_rank
 , promotion_end_date
 , promotion_start_date
 , promotion_end_timestamp
 , promotion_start_timestamp
 ) =
 ( NEW.id
 , NEW.marketing_promotion_group_id
 , NEW.rank
 , NEW.title
 , NEW.image_url
 , NEW.description
 , NEW.include_lead_price
 , NEW.url_type
 , NEW.destination_landing_page_airport_code
 , NEW.destination_landing_page_search_key
 , NEW.hotel_landing_page_room_gds
 , NEW.hotel_landing_page_hotel_code
 , NEW.custom_landing_page_url
 , NEW.data_source
 , NEW.marketing_cache_search_parameters_set_id
 , NEW.marketing_cache_rank
 , NEW.promotion_end_date
 , NEW.promotion_start_date,
 CASE
  WHEN current_setting('switchfly.release_version')::int < 1520000
  THEN
   CAST(NEW.promotion_end_date AS TIMESTAMP)   -- if code is 151, we send the old value converted to the new type or empty, whatever fits your need.
 ELSE
  NEW.promotion_end_timestamp                  -- if code is 152, we send the value from the app.
 END,
 CASE
  WHEN current_setting('switchfly.release_version')::int < 1520000
  THEN
   CAST(NEW.promotion_start_date AS TIMESTAMP) -- if code is 151, we send the old value converted to the new type or empty, whatever fits your need.
 ELSE
  NEW.promotion_start_timestamp                -- if code is 152, we send the value from the app.
 END
 ) WHERE (id) = (OLD.id);
 RETURN NEW;
 ELSIF TG_OP = 'DELETE' THEN
 DELETE FROM marketing_promotion_shadow
 WHERE (id) = (OLD.id);
 RETURN OLD;
 END IF;
 RETURN NEW;
 END; $trigger$;

-- create trigger, using INSTEAD OF not AFTER/BEFORE because of the trigger recursion.
 CREATE TRIGGER insteadof_marketing_promotion_trg
 INSTEAD OF INSERT OR UPDATE OR DELETE
 ON marketing_promotion FOR EACH ROW
 EXECUTE PROCEDURE insteadof_marketing_promotion_dml_fn();

 SELECT grant_permissions('marketing_promotion');

```

*Drop old columns and trigger, function and view generated in the script*

post

```sql
--@LockTables marketing_promotion
-- DROP trigger, function and view
-- RENAME shadow table to normal name.
-- DROP columns not used anymore (old columns)
DROP TRIGGER IF EXISTS insteadof_marketing_promotion_trg ON marketing_promotion;
DROP FUNCTION IF EXISTS insteadof_marketing_promotion_dml_fn();
DROP VIEW IF EXISTS marketing_promotion;
ALTER TABLE marketing_promotion_shadow RENAME TO marketing_promotion;
ALTER TABLE settings.marketing_promotion
 DROP COLUMN promotion_end_date,
 DROP COLUMN promotion_start_date;
```

**Change Table Schema**

We don't specify schema in app code so no work there.
Consider the implications of locking the table, the command will move associated indexes, constraints, and sequences as well.

```sql
--@LockTables my_table
ALTER TABLE  my_table SET SCHEMA my_schema
```

**Add FK Constraint**

The key here is the `NOT VALID` part, which avoids the costly scan/lock of the table during migration.
This means that you need to ensure valid data manually (100 at a time).

**Probably should add index to referencing columns**

> A foreign key must reference columns that either are a primary key or form a
> unique constraint. This means that the referenced columns always have an
> index (the one underlying the primary key or unique constraint); so checks on
> whether a referencing row has a match will be efficient. Since a DELETE of a
> row from the referenced table or an UPDATE of a referenced column will
> require a scan of the referencing table for rows matching the old value, it
> is often a good idea to index the referencing columns too. Because this is
> not always needed, and there are many choices available on how to index,
> declaration of a foreign key constraint does not automatically create an
> index on the referencing columns.

```sql
ALTER TABLE my_table ADD FOREIGN KEY (my_table_fk) REFERENCES another_table(id) NOT VALID
```

**Concurrent Index Generation**

This allows the index to be created in the background without locking the
table.  Without *CONCURRENTLY* update/insert/delete queries will be blocked
until index creation is finished (which means you might need downtime to do
this).

This statesment needs to run in it's own transaction

```sql
CREATE INDEX CONCURRENTLY some_idx ON my_table(some_id);
```

It is possible that this fails silently (exits successfully), the index will be
marked *invalid* and unusable in the system catalogs.  It is a good practice to
run a query to see if it succeeded.

```sql
SELECT
NOT EXISTS
(SELECT 1
FROM pg_class
JOIN pg_index ON pg_class.oid = pg_index.indexrelid
JOIN pg_namespace ON pg_class.relnamespace = pg_namespace.oid
WHERE pg_class.relname = 'YOUR_INDEX_NAME'
AND (pg_index.indisvalid = true OR pg_index.indisready = false))
AS index_built_successfully
;
```

