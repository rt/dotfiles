
```
psql -U postgres -h v205test-v2-pgbouncer.uat.ash.oci.ezrez ezrez_shared
```

# Postgres

```bash
pg_dump -U postgres -h localhost -s ezrez_shared_203 > ezrez_shared_203.sql
```


### Testing DDL migrations

- Checkout master - 1
- Apply pre migrations on rtsunoda_unittest_db_xxx
- cd core && mvn clean install
- Checkout story branch (off master)
- cd core && mvn clean install
- Apply post migrations
- cd core && mvn clean installs


