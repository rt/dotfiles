# Explicit locking when using ALTER TABLE

The *ALTER TABLE* statement acquires an *ACCESS EXCLUSIVE* lock against the
relation it's modifying.  This lock model conflicts with all other lock types,
meaning an *ALTER TABLE* will block until all other queries against a relation
are complete, whether t<F8>y are read-only, or write queries. Because locks are
grandet in the order they are requested, this also means that all subsequent
queries will block until the *ALTER TABLE* statement completes.

Consider,

1. Complicated report query against my_table
2. ALTER TABLE my_table ADD COLUMN foo text;
3. SELECT * FROM my_table;

2. will block until 1. completes because it needs the *ACCESS EXCLUSIVE* lock.
And, because locks are granted in the order of request, 3. will also be blocked.

The solution is to manualy aquire the lock with *LOCK TABLE my_table IN ACCESS EXCLUSIVE MODE NOWAIT*.
If it gets and error (cannot acquire immediately), retry (need to do this in migration app code)

It only makes sense to use @LockTables for short queries, like an ADD COLUMN
without default.  For long queries (e.g., ALTER TABLE ADD COLUMN ... DEFAULT
'foo', which updates the whole table with the default value), we need to use
other strategies to prevent locking (like incrementally updating the table).


```sql
--@LockTables some_table
CREATE TABLE my_table (
  ...
  some_id NOT NULL REFERENCES some_table (some_id),
  ...
);



