# utils

*Get row counts*

```sql
select pg_namespace.nspname || '.' || pg_class.relname as "table", reltuples as "rows" from pg_class join pg_namespace on pg_class.relnamespace = pg_namespace.oid;
```

*See open connection, etc.*

```sql
select * from pg_stat_activity where datname = 'mydatabasename';
```

