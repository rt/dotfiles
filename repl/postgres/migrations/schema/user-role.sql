CREATE TABLE IF NOT EXISTS user_role (
role_id uuid,
user_account_id uuid
);

-- Keys
ALTER TABLE ONLY user_role
ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES common.role(role_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ONLY user_role
ADD CONSTRAINT user_role_user_account_id_fkey FOREIGN KEY (user_account_id) REFERENCES common.user_account(user_account_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Indexes
CREATE INDEX user_role_role_id_index ON user_role USING btree (role_id);
CREATE INDEX user_role_user_account_id_index ON user_role USING btree (user_account_id);

-- Permissions
ALTER TABLE user_role OWNER TO postgres;

