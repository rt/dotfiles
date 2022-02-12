-- post

--@LockTables room
DROP TABLE IF EXISTS room ;

-- Drop column w/nullable
--@LockTables room
ALTER TABLE room DROP COLUMN IF EXISTS serialized_segment ;
