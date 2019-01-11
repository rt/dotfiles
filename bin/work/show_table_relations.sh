#! /usr/bin/env bash

keyword=$1

#filename=sql/table_relation.sql
declare sql=$(<$filename)
read -r -d '' sql <<"EOF"
-- select
    -- t.relname as table_name,
    -- i.relname as index_name,
    -- a.attname as column_name
-- from
    -- pg_class t,
    -- pg_class i,
    -- pg_index ix,
    -- pg_attribute a
-- where
    -- t.oid = ix.indrelid
    -- and i.oid = ix.indexrelid
    -- and a.attrelid = t.oid
    -- and a.attnum = ANY(ix.indkey)
    -- and t.relkind = 'r'
    -- and t.relname like 'test%'
-- order by
    -- t.relname,
    -- i.relname;

    -- roll up column names
select
    t.relname as table_name,
    i.relname as index_name,
    array_to_string(array_agg(a.attname), ', ') as column_names
from
    pg_class t,
    pg_class i,
    pg_index ix,
    pg_attribute a
where
    t.oid = ix.indrelid
    and i.oid = ix.indexrelid
    and a.attrelid = t.oid
    and a.attnum = ANY(ix.indkey)
    and t.relkind = 'r'
    and t.relname like '<keyword>%'
group by
    t.relname,
    i.relname
order by
    t.relname,
    i.relname;
EOF

sql=${sql/<keyword>/$keyword}

psql -U postgres -h localhost -d qaone -c "$sql"

