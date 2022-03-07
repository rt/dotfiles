Things to look out for:

The code is using the schema name as a prefix. Would require code changes if so.
Since we use the `ALTER TABLE` command we ask for an explicit lock. The command execution can be relatively fast, but consider the implications of locking the table. The command will move associated indexes, constraints, and sequences as well.
We generally don't prefix the schema name in code, so usually it's fine to have a migration to simply move the schema.


--@LockTables table_name
ALTER TABLE table_name SET SCHEMA schema_name;
