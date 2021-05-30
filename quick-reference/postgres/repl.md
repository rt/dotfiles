# Postgres

Postgres can be thought of as one global envrionment that you post queries to.

**vim mapping**

*execute file*

`<Leader>tpc`: Executes the current file within psql (must `\c database` first)

*execute statement*

`<Leader>tj`: Executes selected statement(or current line if nothing selected
within psql in a tmux pane (tj: below)

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

