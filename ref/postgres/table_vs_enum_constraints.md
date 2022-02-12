### Checks

To use or not to

Interestingly, these seemed to only be define within the table create statement in a pg_dump.

```sql
    CONSTRAINT table_custom_check CHECK ((arrival_airport_code <> ''::text)),
    CONSTRAINT table_custom_check CHECK ((connector_name <> ''::text)),
    CONSTRAINT table_custom_check CHECK ((departure_airport_code <> ''::text))
    CONSTRAINT table_custom_check CHECK (((((airline IS NOT NULL) AND (airline <> ''::text)) OR ((train_company_name IS NOT NULL) AND (train_company_name <> ''::text))) OR ((bus_company_name IS NOT NULL) AND (bus_company_name <> ''::text)))),
    CONSTRAINT table_custom_check CHECK ((length(country_code) = 2))
```

