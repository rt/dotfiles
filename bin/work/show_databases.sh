#! /usr/bin/env bash

read -r -d '' sql <<"EOF"
SELECT datname FROM pg_database;
EOF

psql -U postgres -h localhost -qtA -c "$sql"

