#! /usr/bin/env bash

#filename=sql/select_config_categories.sql

db=$1

read -r -d '' sql <<"EOF"
SELECT category_name FROM configuration_category;
EOF

psql -U postgres -h localhost -qtA -d "$db" -c "$sql"

