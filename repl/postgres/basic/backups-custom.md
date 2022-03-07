# custom backups

https://www.postgresql.org/docs/current/app-pgdump.html
https://www.postgresql.org/docs/current/app-pgrestore.html

-Fc : makes it a custom backup

https://stackoverflow.com/questions/15692508/a-faster-way-to-copy-a-postgresql-database-or-the-best-way


```bash
# Z 9: --compress=0..9
pg_dump -h localhost -U postgres -Fc -Z 9  --file=file.dump myDb

# -j: --jobs=number-of-jobs
pg_restore -Fc -j 8  file.dump

```

> pg_dump is much faster with compression turned off (-Z0). Obviously, the dump
> is then much bigger. But if you have room and fast disks, it may be the rght
> tradeoff


*table data only from full dump*

```bash
pg_dump -h localhost -U postgres -Fc --file=full.dump --data-only myDb
pg_restore -Fc --data-only -t some_table -d myDb full.dump
```

