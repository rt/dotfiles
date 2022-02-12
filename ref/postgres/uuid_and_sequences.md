# uuid / sequences

Only use uuid to keep it simple. We assign in code rather that database (is
there any benefit to doing it in the database?)

All tables should have an identifier so that dao can be made consistently.

DEPRECATED (here for reference)
```sql
id                     uuid NOT NULL DEFAULT uuid_generate_v1mc(),
```

If we were to use sequence, would need to add to `table.sql`.

```sql
CREATE TABLE IF NOT EXISTS ##tableName## (
    ##fieldName##                     SERIAL,
    -- ...
);

CREATE SEQUENCE ##namespace##.##tableName##_##fieldName##_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE ##namespace##.##tableName##_##fieldName##_seq OWNER TO postgres;

ALTER SEQUENCE ##namespace##.##tableName##_##fieldName##_seq OWNED BY ##namespace##.##tableName##.##fieldName##;

ALTER TABLE ONLY ##namespace##.##tableName## ALTER COLUMN ##fieldName## SET DEFAULT nextval('##namespace##.##tableName##_##fieldName##_seq'::regclass);
```
