
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

