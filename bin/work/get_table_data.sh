#! /usr/bin/env bash

db=$1
tablename=$2

#filename=sql/table_data.sql
#declare sql=$(<$filename)

read -r -d '' sql <<"EOF"
SELECT * FROM <tablename>;
EOF

sql=${sql/<tablename>/$tablename}

psql -U postgres -h localhost -d $db -c "$sql"

