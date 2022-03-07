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

