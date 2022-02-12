--@LockTables table_to_reference_name
ALTER TABLE table_name ADD FOREIGN KEY (table_fk) REFERENCES table_to_reference_name(id) NOT VALID;



-- By adding the "NOT VALID" option the "FOREIGN KEY" will avoid a costly scan/lock of the table during the migration. You will need to ensure that data is valid (via deleting/updating conflicting rows) manually via scripts run before/after depending on the use case. The win here is that these scripts can be written in a way that is less blocking (e.g. update 100 rows at a time) then the addition of the constraint without the "NOT VALID".

-- Once the constraint with the "NOT VALID" option is in place it will take effect for every INSERT and UPDATE, if the updating row is updated the foreign key column and that key is not being updated to null.

-- Using the --@LockTables keyword uses explicit locking to ensure the query will not execute until a lock can be acquired.



Many of these tables have a "DEFAULT 0" clause in their table definition. This has to be removed in a pre-migration.
Change the code to either put a proper id in a foreign key column or null. Much current code simply fetches the id from a java int variable, which defaults to zero if it has not been set. It is tempting to change all of these int fields to Integer fields, but I think that is the wrong approach. That will lead to lots of null checks all over the place that take the place of the zero checks where they are applicable. It doesn't save much and can lead to very confusing bugs when auto-unboxing is invoke on a null value. I prefer an approach for now that simply updates repositories to check for zero and use null if it is found.
Note that SELECT statements can be ignored. We have to find all INSERT and UPDATE statements.
In a post migration, add a constraint for the foreign keys, but use the NOT VALID clause. This forces new rows to satisfy the constraint, but does not check existing rows. This is vital to avoid a long running and blocking transaction.
In a post-migration, change all zero columns to null. This should be done with the newly created migration annotation @UpdateZeroToNull. This will change a maximum of 5000 rows at a time to avoid a long running and blocking transaction.
In a post migration, delete the invalid rows. This should use the NOT EXISTS clause for performance reasons.
At this point, the table is tight. All existing rows satisfy the new constraints and new rows will be validated before insertion. There may be some additional cleanup you can do.

Study the CleanupDatabaseProcessor. This call various repositories and deletes old rows. Many repositories explicitly look for their linked children to remove them. With the constraints added above, this is no longer necessary and can be removed.




