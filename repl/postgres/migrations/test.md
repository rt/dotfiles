# Testing Migrations

It might be possible to test migrations especially if we have the schema specs.

**Setup database**

*generate_series*

```sql
-- this will add 1 million rows from current_date + x (where x is incremented by the last parameter in the function)
INSERT INTO test_table (field_date) (SELECT current_date + s.a AS field_date FROM generate_series(0,1000000, 1) AS s(a));
```

Do not try to add 100 million rows in an INSERT operation, do it in chunks and it will be faster.

**Run migration in one connection**

```sql
ALTER TABLE test_table ALTER COLUMN field_date TYPE TIMESTAMP WITHOUT TIME ZONE;
```

**Run CRUD in another connection**


```sql
-- SELECT data
SELECT * FROM test_table LIMIT 10;
  
-- INSERT data
INSERT INTO test_table (field_date) (SELECT current_date + s.a AS field_date FROM generate_series(0,1, 1) AS s(a));
  
-- UPDATE data
UPDATE test_table SET field_date = now();
  
-- DELETE data
DELETE FROM test_table;
```
