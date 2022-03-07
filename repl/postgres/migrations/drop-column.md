
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

