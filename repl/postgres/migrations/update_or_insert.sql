
A really neat way to do UpdateOrInsert (upsert) with PG:

WITH upsert AS (UPDATE translations SET translation='TTT', type='YYY' WHERE name='NNN' RETURNING *)
INSERT INTO translations (name, translation, type) SELECT 'NNN', 'TTT', 'YYY' WHERE NOT EXISTS (SELECT * FROM upsert);

