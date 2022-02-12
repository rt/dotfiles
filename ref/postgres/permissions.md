### Permissions

```sql
REVOKE ALL ON TABLE ##namespace##.##tableName## FROM PUBLIC;
REVOKE ALL ON TABLE ##namespace##.##tableName## FROM postgres;
GRANT ALL ON TABLE ##namespace##.##tableName## TO postgres;
GRANT ALL ON TABLE ##namespace##.##tableName## TO service;
GRANT SELECT ON TABLE ##namespace##.##tableName## TO readonly;
```


