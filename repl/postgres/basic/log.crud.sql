
-- uuid too cumbersome to work with in repl
-- INSERT INTO log(log_id, type) VALUES ('a0ee-bc99-9c0b-4ef8-bb6d-6bb9-bd38-0a11', 'typeA');
-- INSERT INTO log(log_id, type) VALUES ('a0bb', 'another type'); -- error invalid uuid
-- INSERT INTO log(log_id, type) VALUES ('a0ee-bc99-9c0b-4ef8-bb6d-6bb9-bd38-0a11', 'another type'); -- duplicate key 

INSERT INTO log(log_id, type) VALUES (1, 'typeA');
INSERT INTO log(log_id, type) VALUES (2, 'typeB');

UPDATE log SET type = 'typeB' WHERE type = 'typeA';

SELECT * FROM log;

SELECT * FROM log WHERE type = 'typeB';

DELETE FROM log WHERE type = 'typeB';
