----- user_account -----

CREATE TABLE IF NOT EXISTS user_account (
user_account_id int,
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


----- role -----

CREATE TABLE IF NOT EXISTS role (
role_id int,
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
role_id int,
user_account_id int
);

-- Keys
ALTER TABLE ONLY user_role
ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES role(role_id) 
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ONLY user_role
ADD CONSTRAINT user_role_user_account_id_fkey FOREIGN KEY (user_account_id) REFERENCES user_account(user_account_id) 
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Indexes
CREATE INDEX user_role_role_id_index ON user_role USING btree (role_id);
CREATE INDEX user_role_user_account_id_index ON user_role USING btree (user_account_id);

-- Permissions
ALTER TABLE user_role OWNER TO postgres;


----- permissions -----


CREATE TABLE IF NOT EXISTS permission (
    id                  SERIAL,
    name                character varying(50),
    -- Keys
    CONSTRAINT permission_pkey PRIMARY KEY (id)
);

----- role_permission -----


CREATE TABLE IF NOT EXISTS role_permission (
    role_id             int NOT NULL,
    permission_id       int NOT NULL,
    -- Keys
    CONSTRAINT role_permission_pkey PRIMARY KEY (role_id, permission_id),

    CONSTRAINT role_permission_role_fkey FOREIGN KEY (role_id)
    REFERENCES role (id) MATCH SIMPLE 
    ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT role_permission_permission_fkey FOREIGN KEY (permission_id)
    REFERENCES permission (id) MATCH SIMPLE
    ON DELETE CASCADE ON UPDATE CASCADE
);



-- create generic permisssion
INSERT INTO permission (name)
VALUES ('genericUserPerm');

INSERT INTO permission (name)
VALUES ('genericAdminPerm1');

INSERT INTO permission (name)
VALUES ('genericAdminPerm2');

-- create user and admin role
INSERT INTO role (name)
VALUES ('user');

INSERT INTO role (name)
VALUES ('admin');

-- add permissions to roles
INSERT INTO role_permission (role_id, permission_id)
VALUES 
((SELECT id FROM role WHERE name='user'), (SELECT id FROM permission WHERE name='genericUserPerm')),
((SELECT id FROM role WHERE name='admin'), (SELECT id FROM permission WHERE name='genericAdminPerm1')),
((SELECT id FROM role WHERE name='admin'), (SELECT id FROM permission WHERE name='genericAdminPerm2'));
