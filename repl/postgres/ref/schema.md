### Generating the schema

Tables are generated from the dao specs. The main models will generate
their tables and the child tables (oneToOne and oneToMany relationships) The
oneToOne relations must be one-way and the `via` tag should not be used in the
child table (to avoid recursion)

*Constraints*

- CHECK

- PRIMARY KEY

```sql
ALTER TABLE ONLY ${model.name}
    ADD CONSTRAINT ${model.name}_pkey PRIMARY KEY (${field.name});
```

- UNIQUE

```sql
ALTER TABLE ONLY ${model.name}
    ADD CONSTRAINT ${model.name}_${field.name}_key UNIQUE (${field.name});
```

- Indexes

Postgres will not automatically create an index on the referenced columns of a foreign key

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
CREATE INDEX ${model.name}_index ON ${model.name} USING btree (${field.name});
CREATE UNIQUE INDEX ${model.name}_index ON ${model.name} USING btree (${field.name});
```

- FOREIGN KEY

```sql
ALTER TABLE ONLY ${model.name}
    ADD CONSTRAINT ${model.name}_${field.name}_fkey FOREIGN KEY (${field.name}) REFERENCES ${field.referenceModel}(${field.name})
```


