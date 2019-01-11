#! /usr/bin/env bash

db=$1
tablename=$2

#filename=sql/table_definition.sql
#filename=sql/table_def.sql
#declare sql=$(<$filename)

#SELECT 
  #column_name, 
  #data_type, 
  #character_maximum_length
#FROM INFORMATION_SCHEMA.COLUMNS 
#WHERE table_name = '<tablename>';

read -r -d '' sql <<"EOF"
SELECT  
    f.attnum AS number,  
    f.attname AS name,  
    f.attnum,  
    f.attnotnull AS notnull,  
    pg_catalog.format_type(f.atttypid,f.atttypmod) AS type,  
    CASE  
        WHEN p.contype = 'p' THEN 't'  
        ELSE 'f'  
    END AS pk, -- primarykey
    CASE  
        WHEN p.contype = 'u' THEN 't'  
        ELSE 'f'
    END AS uk, --uniquekey
    CASE
        WHEN p.contype = 'f' THEN g.relname
    END AS fk, --foreignkey
    CASE
        WHEN p.contype = 'f' THEN p.confkey
    END AS fk_fieldnum,
    CASE
        WHEN p.contype = 'f' THEN p.conkey
    END AS fk_connnum,
    CASE
        WHEN f.atthasdef = 't' THEN d.adsrc
    END AS default
FROM pg_attribute f  
    JOIN pg_class c ON c.oid = f.attrelid  
    JOIN pg_type t ON t.oid = f.atttypid  
    LEFT JOIN pg_attrdef d ON d.adrelid = c.oid AND d.adnum = f.attnum  
    LEFT JOIN pg_namespace n ON n.oid = c.relnamespace  
    LEFT JOIN pg_constraint p ON p.conrelid = c.oid AND f.attnum = ANY (p.conkey)  
    LEFT JOIN pg_class AS g ON p.confrelid = g.oid  
WHERE c.relkind = 'r'::char  
    -- AND n.nspname = 'settings'  -- Replace with Schema name  
    AND c.relname = '<tablename>'  -- Replace with table name  
    AND f.attnum > 0 ORDER BY number
;
EOF

sql=${sql/<tablename>/$tablename}

psql -U postgres -h localhost -d $db -c "$sql"

