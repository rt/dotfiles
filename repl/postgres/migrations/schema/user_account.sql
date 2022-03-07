CREATE TABLE IF NOT EXISTS user_account (
user_account_id uuid,
username character varying(256)

-- email character varying(256),
-- email_confirmed boolean NOT NULL DEFAULT false,
-- passwordHash character varying(256),
-- passwordSalt character varying(100),
-- status character varying(256) NOT NULL DEFAULT 'active',
-- two_factor_enabled boolean NOT NULL DEFAULT false,
-- concurrency_stamp int,
-- access_failed_count smallint NOT NULL DEFAULT 0,
-- lockout_end timestamp without time zone,
-- lockout_enabled boolean NOT NULL DEFAULT false
);

-- Keys
ALTER TABLE ONLY user_account
ADD CONSTRAINT user_account_pkey PRIMARY KEY (user_account_id);

-- Indexes
CREATE INDEX user_account_username_index ON user_account USING btree (username);

-- Permissions
ALTER TABLE user_account OWNER TO postgres;


