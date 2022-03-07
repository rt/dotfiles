# dump/restore

*backup all schema and data*

```bash
# backup
pg_dump -h localhost -U postgres test_playground > test_playground.sql

# schema and data
#pg_dump -h localhost -U postgres --schema=public test_playground > public.sql

# single table
# pg_dump -h localhost -U postgres test_playground -t log > table.sql

# schema only:  --schema-only = -s
#pg_dump -h localhost -U postgres --schema-only test_playground > test_playground.sql
```

```bash
# ddm modification
# psql -h localhost -U postgres -d test_playground -c "INSERT INTO log(log_id, type) VALUES (100, 'blah');"
# psql -h localhost -U postgres -d test_playground -c "SELECT * from log;"

# drop / create db 
psql -h localhost -U postgres -c "DROP DATABASE test_playground;"
psql -h localhost -U postgres -c "CREATE DATABASE test_playground;"

```

```bash
# restore (this just applies, so you must have a empty db)
psql -d test_playground -h localhost -U postgres < test_playground.sql

# one schema and data
# psql -d test_playground -h localhost -U postgres < public.sql

# single table (note this can have problems if there are constraints ... use pg_restore..)
# psql -d test_playground -h localhost -U postgres < table.sql

# schema only
#psql -d test_playground -h localhost -U postgres < test_playground.sql
```

```bash
psql -h localhost -U postgres -d test_playground -c "SELECT * from log;"
```



*from remote*

Same things apply.

```bash
psql -U postgres -h localhost -c 'CREATE DATABASE test_playground;'
pg_dump -h remote_host -U postgres test_playground | psql -U postgres -h localhost test_playground
```
