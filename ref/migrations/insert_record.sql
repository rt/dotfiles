-- pre

-- Find out types
-- SELECT type, count(*) FROM translations GROUP BY type ORDER BY type;

INSERT INTO translations (name, translation, type) VALUES
    ('AIR_LEG_SELECTION', 'Currently Selected', 'label'),
    ('AIR_LEG_TITLE', 'Flight', 'label');
