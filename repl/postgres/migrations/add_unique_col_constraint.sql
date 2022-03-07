

-- ORDER BY id is not necessary, remove it to improve performance
-- it only exists so that the postfix increment goes along with the id column order
WITH repeated_names AS (
    SELECT name_column
        FROM table_name
        GROUP BY name_column
        HAVING COUNT(name_column) > 1
), to_update AS(
    SELECT  id,
        table_alias.name_column,
        row_number() OVER (PARTITION BY table_alias.name_column ORDER BY id) AS postfix
        FROM table_name AS table_alias
        JOIN repeated_names
        USING (name_column)
)
UPDATE table_name
    SET name = to_update.name_column || '_' || postfix
    FROM to_update
    WHERE table_name.id = to_update.id;
  
ALTER TABLE table_name ADD UNIQUE(name_column);


Pre or Post
This type of script should be less problematic as a .post, since "pre-code" supports duplicates. But in some scenarios could be a .pre script, I think this depends on the situation.

Explanation
If you need to add a unique constraint to a column on table that is already deployed on prod or UAT, there's a chance that you have rows with duplicate values. If that's the case and you try to add the constraint an error would be thrown. To prevent this you have to:

Update duplicate values in a way that they are not duplicate
Add the constraint




Testing
Create table "duplicate_name_test_table", it contains 2 columns id and name.
Insert rows with duplicate name values.
Select the content on the table


DROP TABLE IF EXISTS duplicate_name_test_table;
CREATE TABLE duplicate_name_test_table (
     id SERIAL PRIMARY KEY,
     name TEXT NOT NULL
);
  
INSERT INTO duplicate_name_test_table(name) VALUES ('foo'),('foo'),('bar'),('bar'),('bar'),('something'),('not'),('repeated');
  
SELECT * FROM duplicate_name_test_table ORDER BY id;



Result:

1	foo
2	foo
3	bar
4	bar
5	bar
6	something
7	not
8	repeated
If you try to add a unique constraint it will throw an error:

ALTER TABLE duplicate_name_test_table ADD UNIQUE(name);
Result:

ALTER TABLE duplicate_name_test_table ADD UNIQUE(name);
ERROR: could not create unique index "duplicate_name_test_table_name_key"
DETAIL: Key (name)=(foo) is duplicated.

********** Error **********

ERROR: could not create unique index "duplicate_name_test_table_name_key"
SQL state: 23505
Detail: Key (name)=(foo) is duplicated.

Let's do it again by correcting the duplicate name data:

Get duplicate "name" values.
Only for rows with duplicate name values:
Get id
Get name
A postfix number based on the row position number on the window frame
Update those rows by setting name + '_' + postfix
Add UNIQUE constraint to name column.
Select the content on the table.


-- ORDER BY id is not necessary, remove it to improve performance
WITH repeated_names AS (
    SELECT name
        FROM duplicate_name_test_table
        GROUP BY name
        HAVING COUNT(name) > 1
), to_update AS(
    SELECT  id,
        table_alias.name,
        row_number() OVER (PARTITION BY table_alias.name ORDER BY id) AS postfix
        FROM duplicate_name_test_table AS table_alias
        JOIN repeated_names
        USING (name)
)
UPDATE duplicate_name_test_table
    SET name = to_update.name || '_' || postfix
    FROM to_update
    WHERE duplicate_name_test_table.id = to_update.id;

ALTER TABLE duplicate_name_test_table ADD UNIQUE(name);

SELECT * FROM duplicate_name_test_table ORDER BY id;


Result:

1	foo_1
2	foo_2
3	bar_1
4	bar_2
5	bar_3
6	something
7	not
8	repeated

