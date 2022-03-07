-- pre shared
INSERT INTO translations (name, translation, type)
    SELECT 'NTS_HEADER_NEW', translation, type
        FROM translations
        WHERE name = 'NTS_HEADER_OLD';

-- pre client
INSERT INTO translations (name, translation, type, langid, segmentation_id)
    SELECT 'NTS_HEADER_NEW', translation, type, langid, segmentation_id
        FROM translations
        WHERE name = 'NTS_HEADER_OLD';

-- post shared
DELETE FROM translations WHERE name = 'NTS_HEADER_OLD';

-- post client
DELETE FROM translations WHERE name = 'NTS_HEADER_OLD';


