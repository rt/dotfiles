
Use Explicit Locking When Using ALTER TABLE
The ALTER TABLE statement acquires an ACCESS EXCLUSIVE lock against the relation it's modifying. This lock mode conflicts with all other lock types, meaning an ALTER TABLE will block until all other queries against a relation are complete, whether they are read-only, or write queries. Because locks are granted in the order they are requested, this also means that all subsequent queries will block until the ALTER TABLE statement completes.

Consider the following example:

Query #1: Complicated report query against customer, room, car tables.
Query #2: ALTER TABLE customer ADD COLUMN foo text;
Query #3: SELECT entered_date FROM customer WHERE id = 1;

In the above example, Query #2 will block until Query #1 completes. Even though it's very fast to add a new column without a default value, it still needs an ACCESS EXCLUSIVE lock, so it will block until all other queries complete, even reads. And because locks are granted in the order they are requested, Query #3 will also be blocked by Query #2.

The solution to this problem is to use explicit locking. Instead of relying on ALTER TABLE to acquire the lock, we can first manually acquire the lock, but specify the database should return an error if it can't immediately acquire the lock. We can then retry acquiring the lock in application code.

Since 16.1, we have a keyword to enable this behavior: --@LockTables <Comma-separated list of tables>. This keyword will execute "LOCK TABLE <table> IN ACCESS EXCLUSIVE MODE NOWAIT." If it gets an error (in other words, it can't acquire the lock immediately), it will retry every half second until it can acquire the lock, or a timeout period expires.


Scenario: Adding a new table with a foreign key to an existing table

CREATE TABLE segment_map (
segment_map_id serial PRIMARY KEY,
custid int NOT NULL REFERENCES customer (id),
room_id NOT NULL REFERENCES room (id)
);


How to

Use --@LockTables to specify the tables which should be locked. Because there are two new primary keys referencing customer and room, both those tables should be explicitly locked:

--@LockTables customer, room
CREATE TABLE segment_map (
segment_map_id serial PRIMARY KEY,
custid int NOT NULL REFERENCES customer (id),
room_id NOT NULL REFERENCES room (id)
);


Scenario: Adding a new column

ALTER TABLE customer ADD COLUMN foo text;

How To:

--@LockTables customer
ALTER TABLE customer ADD COLUMN foo text;
