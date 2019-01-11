#! /usr/bin/env bash

db=$1
tablename=$2

read -r -d '' sql <<EOF
SELECT column_name FROM information_schema.columns WHERE table_name ='$tablename';
EOF

psql -U postgres -h localhost -qtA -d $db -c "$sql"

