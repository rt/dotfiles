-- 1420001.sql.pre

--@LockTables room_contract
CREATE TABLE settings.room_contract_min_max_stay_rule
(
  room_contract_min_max_stay_rule_id SERIAL PRIMARY KEY,
  room_contract_id integer NOT NULL
    REFERENCES settings.room_contract (room_contract_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  check_in_date date,
  check_out_date date,
  min_night_stay integer NOT NULL DEFAULT 1,
  max_night_stay integer NOT NULL DEFAULT 365
);
SELECT grant_permissions('room_contract_min_max_stay_rule');
CREATE INDEX ON settings.room_contract_min_max_stay_rule(room_contract_id);


-- This function will be used to automatically migrate the new/modified data in room_contract to the new table
-- a separate migration was written to migrate existing records, see next migration for details.
CREATE OR REPLACE FUNCTION move_old_min_max_stays_to_new_schema_function()
  RETURNS trigger AS $$
BEGIN -- Delete existing record in order to update values
  DELETE FROM settings.room_contract_min_max_stay_rule
  WHERE room_contract_id = NEW.room_contract_id;
  INSERT INTO settings.room_contract_min_max_stay_rule
    (room_contract_id, check_in_date, check_out_date, min_night_stay, max_night_stay)
  VALUES
    (NEW.room_contract_id, null, null, coalesce(NEW.minstay, 1), coalesce(NEW.maxstay, 365));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER room_contract_migrate_min_max_stays_trigger
AFTER INSERT OR UPDATE ON settings.room_contract
FOR EACH ROW EXECUTE PROCEDURE move_old_min_max_stays_to_new_schema_function();



-- 1420002.sql.pre

-- Migrate existing data to new table
INSERT INTO settings.room_contract_min_max_stay_rule
(room_contract_id, check_in_date, check_out_date, min_night_stay, max_night_stay)
  SELECT room_contract_id, null, null, coalesce(minstay, 1), coalesce(maxstay, 365)
  FROM settings.room_contract;


-- 1420003.sql.post

--@LockTables room_contract
DROP TRIGGER IF EXISTS room_contract_migrate_min_max_stays_trigger ON settings.room_contract;
DROP FUNCTION IF EXISTS move_old_min_max_stays_to_new_schema_function();
ALTER TABLE settings.room_contract
  DROP COLUMN IF EXISTS minstay,
  DROP COLUMN IF EXISTS maxstay;



-- On Stage 1, old application code still references field in room contract table.
-- On Stage 2. new application code references new table, but old code still references fields in room contract, any change made on fields are going to be replicated to the new table by the trigger.
-- On Stage 3. new application code no longer needs old table fields.



