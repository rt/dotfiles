-- pre
--@LockTables hotel_enrichment_hotel_amenities
ALTER TABLE hotel_enrichment_hotel_amenities ADD COLUMN great_message text; 

-- w/NOT NULL DEFAULT
@AddColumnWithDefaultNotNull{
    "tableNames" : ["alamo_locations"],
    "columnName" : "is_valid",
    "type" : "boolean",
    "defaultValue" : "true",
    "idColumnName" : "alamo_locationsid"
}

-- This will execute a three step process to add the column with a default
-- value, update the column to the given default, and then add a not null
-- constraint to the column.  It breaks up these steps and the update in such a
-- way that it minimizes table locking.  Available in release 15.5 and
-- afterwards.

-- tableNames can include multiple tables (for example ["hotel_fee",
  -- hotel_fee_duplicates"]), as long as both tables can use the same name for
-- the idColumnName.  

-- type can be any valid postgres column type (for example, "text", "timestamp
  -- without time zone", "double precision").

-- defaultValue can be any valid postgres constant (for example, "'default
  -- text'", "'2004-01-01 00:00:00.000000-00'", "42.0").

-- Limit to 1 @AddColumnWithDefaultNotNull per script.  If you have multiple
-- columns that you need to add with defaults, create a separate migration
-- script for each.


-- w/NOT NULL DEFAULT manually

-- pre
--@LockTables hotel_enrichment_hotel_amenities

-- 1
ALTER TABLE hotel_enrichment_hotel_amenities
    ADD COLUMN is_valid boolean,
    ALTER COLUMN is_valid SET DEFAULT true ;

-- 2
UPDATE hotel_enrichment_hotel_amenities SET is_valid = true;

-- 3
--@LockTables hotel_enrichment_hotel_amenities
ALTER TABLE hotel_enrichment_hotel_amenities
    ALTER COLUMN is_valid SET NOT NULL ;

-- 3 pre migration scripts must be created to avoid locking the table as well as deadlock so application can continue to proceed.

-- 1.sql.pre may contain multiple columns.

-- 3.sql.pre above will lock the table but the duration of lock should be minimum as majority of rows in the table should be updated from 1220001.sql.pre

-- Newly inserted rows by  the time of 1220002.sql.pre, will have default value set to 0.0 from

-- "SET DEFAULT true" clause from 1220000.sql.pre will *not* update existing
-- row. If you do below instead, will lock and update the table at the same
-- time. Which is no-go if you have big data in the table and no connection can
-- even read from the table while update in progress:
--  ALTER TABLE hotel_enrichment_hotel_amenities
--         ADD COLUMN is_valid boolean DEFAULT true ;

-- When adding columns for multiple tables...
--1.sql.pre may include multiple tables.
--2.sql.pre should NOT include multiple tables.  The UPDATEs should be separated into separate scripts, one for each table.
--3.sql.pre may include multiple tables.
