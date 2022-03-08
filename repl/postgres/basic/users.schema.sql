----- user_account -----

CREATE TABLE IF NOT EXISTS user_account (
user_account_id uuid,
username character varying(256),
email character varying(256),
email_confirmed boolean NOT NULL DEFAULT false,
passwordHash character varying(256),
passwordSalt character varying(100),
status character varying(256) NOT NULL DEFAULT 'active',
two_factor_enabled boolean NOT NULL DEFAULT false,
concurrency_stamp int,
access_failed_count smallint NOT NULL DEFAULT 0,
lockout_end timestamp without time zone,
lockout_enabled boolean NOT NULL DEFAULT false
);

-- Keys
ALTER TABLE ONLY user_account
ADD CONSTRAINT user_account_pkey PRIMARY KEY (user_account_id);

-- Indexes
CREATE INDEX user_account_username_index ON user_account USING btree (username);

-- Permissions
ALTER TABLE user_account OWNER TO postgres;


----- role -----

CREATE TABLE IF NOT EXISTS role (
role_id uuid,
name character varying(256)
);

-- Keys
ALTER TABLE ONLY role
ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);

-- Indexes


-- Permissions
ALTER TABLE role OWNER TO postgres;



----- user_role -----


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


