
Get row counts

```sql
select pg_namespace.nspname || '.' || pg_class.relname as "table", reltuples as "rows" from pg_class join pg_namespace on pg_class.relnamespace = pg_namespace.oid;
```

```sql

CREATE TABLE IF NOT EXISTS log (
log_id uuid,
type character varying(256) NOT NULL DEFAULT ''
);

-- Keys
ALTER TABLE ONLY log
ADD CONSTRAINT log_pkey PRIMARY KEY (log_id);

-- Indexes
CREATE INDEX log_index ON log USING btree (type);

-- Permissions
ALTER TABLE log OWNER TO postgres;



```
