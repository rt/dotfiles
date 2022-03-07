-- Drop column w/not null

-- pre
--@LockTables pnr_manager_remark_contract
ALTER TABLE pnr_manager_remark_contract ALTER COLUMN remark_text DROP NOT NULL;

-- post
--@LockTables pnr_manager_remark_contract
ALTER TABLE pnr_manager_remark_contract DROP COLUMN IF EXISTS remark_text ;

-- We added new code in which we are no longer adding values into the column
-- remark text in the pnr_manager_remark_contract table. This code will be
-- pushed to production before the remark text is dropped from the table as a
-- post script.  If a new row is added to this table before the post script is
-- run, a value for the remark text will not be added to the row.  Therefore,
-- in the pre script, we need to remove the NOT NULL constraint on the remark
-- text in the pre script so that new rows can be added to the
-- pnr_manager_remark_contract table without causing  an error.
