
CREATE TABLE IF NOT EXISTS log (
-- log_id uuid,
log_id integer NOT NULL,
type character varying(256) NOT NULL DEFAULT ''
);

-- Keys
ALTER TABLE ONLY log
ADD CONSTRAINT log_pkey PRIMARY KEY (log_id);

-- Indexes
CREATE INDEX log_index ON log USING btree (type);

-- Permissions
ALTER TABLE log OWNER TO postgres;
