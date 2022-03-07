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


