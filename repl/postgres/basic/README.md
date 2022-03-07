# Create db and start playing


*in psql*

```bash
psql -h localhost -U postgres
```

```sql
CREATE DATABASE test_playground;
\c test_playground;
```

*make schema*
```sql

CREATE TABLE IF NOT EXISTS log (
-- log_id uuid,
log_id integer NOT NULL,
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

*add data*

```sql

-- uuid too cumbersome to work with in repl
-- INSERT INTO log(log_id, type) VALUES ('a0ee-bc99-9c0b-4ef8-bb6d-6bb9-bd38-0a11', 'typeA');
-- INSERT INTO log(log_id, type) VALUES ('a0bb', 'another type'); -- error invalid uuid
-- INSERT INTO log(log_id, type) VALUES ('a0ee-bc99-9c0b-4ef8-bb6d-6bb9-bd38-0a11', 'another type'); -- duplicate key 

INSERT INTO log(log_id, type) VALUES (1, 'typeA');
INSERT INTO log(log_id, type) VALUES (2, 'typeB');

UPDATE log SET type = 'typeB' WHERE type = 'typeA';

SELECT * FROM log;

SELECT * FROM log WHERE type = 'typeB';

DELETE FROM log WHERE type = 'typeB';

```


```sql
\c postgres
DROP DATABASE test_playground;
```


