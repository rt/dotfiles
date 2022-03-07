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


