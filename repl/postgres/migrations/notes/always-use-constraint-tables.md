# Always use constraint tables

If you always have a constraint table updating constraints follow the same
rules (Add, Delete, Move).  But if you use hardcoded constraints like the
following you would have to update the database(source) first on a Delete.

```sql
CONSTRAINT xxx_check CHECK ((field_name = ANY (ARRAY['OPT1'::text, 'OPT2'::text]))),
```

Updating this constraint is harder (could use a migration time annotation) than add/remove data from the constraint table.
Better to have.

```sql
CREATE TABLE child_table (
  child_table_id int PRIMARY KEY,
  ...
);

INSERT INTO child_table (name) VALUES ('OPT1');
INSERT INTO child_table (name) VALUES ('OPT2');

CREATE TABLE root_table (
  ...
  child_table_id int REFERENCES child_table,
  ...
);
```

