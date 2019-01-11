#! /usr/bin/env bash

db=$1
#filename=sql/show_tables.sql

#declare sql=$(<$filename)

#SELECT
 #tablename
#FROM
 #pg_catalog.pg_tables
#WHERE
 #schemaname != 'pg_catalog'
#AND schemaname != 'information_schema';

read -r -d '' sql <<"EOF"
SELECT 
  table_name 
FROM 
  information_schema.tables 
WHERE 
  table_schema = 'public'
  OR table_schema = 'settings';
EOF

#echo $sql

psql -U postgres -h localhost -qtA -d "$db" -c "$sql"
