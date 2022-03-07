# psql

**psql**

```bash
# if psql is on local
psql -U postgres -h localhost

# Or, use docker instance
docker exec -it postgresql psql -U postgres -h localhost


# list databases
\l
# change db
\c <database>
# list schemas
\dn
# get tables and sequences
\d
# get tables
\dt
# get table def
\d <table>

# any sql queries against db...
```

