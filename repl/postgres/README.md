# Postgres

**postgres instance as daemon**
```bash

docker run --rm --name postgresql -p 5432:5432 -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=demodb -d postgres:latest

```

**psql**
```bash

docker exec -it postgresql psql -d demodb -U admin

```

Postgres can be thought of as one global envrionment that you post queries to.

**vim mapping**

*execute file*

`<Leader>tpc`: Executes the current file within psql (must `\c database` first)


### Create db and start playing

```sql
psql -U postgres -h localhost
```

```sql
CREATE DATABASE test_playground;
```

```sql
\c test_playground;
```


Do stuff ...



```sql
\c postgres
```

```sql
DROP DATABASE test_playground;
```

### Setup

Set up basic tables to test on


### Data

Get data into the tables


### Scenarios

Different migration scenarios


### Functions

Various functions you can push into the database

