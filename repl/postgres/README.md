# Postgres

https://www.postgresql.org/docs

Divided up into admin and migration.
- admin: basic db/table to test basic things and administrative tasks
- migrations: user/role schema to tests migration tasks

Postgres can be thought of as one global envrionment that you post queries to.

**postgres instance as daemon**

https://hub.docker.com/_/postgres

```bash
docker run --rm --name postgresql -p 5432:5432 -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=demodb -d postgres:latest
```
