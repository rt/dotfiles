alias psql.columns="show_columns"
alias psql.showDatabases="show_databases"
alias psql.showTables="show_tables"
alias psql.getTableData="get_table_data"
alias psql.getTableDefinition="get_table_definition"
alias psql.showTableRelations="show_table_relations"

show_columns() {
  db=$1
  tablename=$2

  read -r -d '' sql <<EOF
SELECT column_name FROM information_schema.columns WHERE table_name ='$tablename';
EOF

  psql -U postgres -h localhost -qtA -d $db -c "$sql"
}

show_databases() {
  read -r -d '' sql <<"EOF"
SELECT datname FROM pg_database;
EOF

  psql -U postgres -h localhost -qtA -c "$sql"
}

show_tables() {
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
}

get_table_data() {
  db=$1
  tablename=$2

#filename=sql/table_data.sql
#declare sql=$(<$filename)

read -r -d '' sql <<"EOF"
SELECT * FROM <tablename>;
EOF

  sql=${sql/<tablename>/$tablename}

  psql -U postgres -h localhost -d $db -c "$sql"
}

get_table_definition() {
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
}

show_table_relations() {
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
}
