CREATE FUNCTION public.ddl2rename(names text[], target_release integer) RETURNS SETOF text
    LANGUAGE plpgsql
    AS $_$
/******************************************************************************
 * Generate DDL statements to rename for no-downtime DB migration at Switchfly
 *
 * Revision: 0.5b
 * Usage:
 *   ddl2rename('{{old_tbl,new_tbl},{old_col1,new_col1},{old_col2,new_col2}}', rel)
 *   ddl2rename(ARRAY[['old_tbl','new_tbl'],['old_col1','new_col1'],['old_col2','new_col2']], rel)
 *
 * Scenario#1: rename a table
 *   SELECT ddl2rename('{{xout,blackout}}', 130);
 *
 * Scenario#2: rename only columns, but not table
 *   SELECT ddl2rename('{{xout,NULL},{id,blackout_id},{xdate,blackout_date}}', 130);
 *
 * Scenario#3: rename a table and its columns
 *   SELECT ddl2rename('{{xout,blackout},{id,blackout_id},{xdate,blackout_date}}', 130);
 *
 *****************************************************************************/
DECLARE
  old_table_name  text := names[1][1];
  new_table_name  text := coalesce(names[1][2],old_table_name||'_shadow');
  old_primary_key text;
  new_primary_key text;
  column_rename_only boolean := (names[1][2] IS NULL OR names[1][1] = names[1][2])::boolean;
  old_chg_columns text[];
  new_chg_columns text[];
  old_all_columns text[];
  new_all_columns text[];
  view_aliases    text[];
  default_values  text[];
BEGIN
  RAISE NOTICE 'old_table_name = %',old_table_name;
  RAISE NOTICE 'new_table_name = %',new_table_name;
  FOR i IN 2 .. array_length(names, 1) LOOP
    old_chg_columns[i-1] := names[i][1];
    new_chg_columns[i-1] := names[i][2];
  END LOOP;
  RAISE NOTICE 'old_column_names = %',old_chg_columns;
  RAISE NOTICE 'new_column_names = %',new_chg_columns;

  -- Populate the primary key
  SELECT string_agg(attname, ',')
  , string_agg(
      CASE WHEN attname = ANY(old_chg_columns) THEN
        new_chg_columns[array_idx(old_chg_columns,attname::text)]
        ELSE attname
      END, ',')
  INTO old_primary_key, new_primary_key
  FROM pg_index JOIN pg_class ON (indrelid = pg_class.oid)
  JOIN pg_attribute ON (attrelid = pg_class.oid AND attnum = ANY(indkey))
  WHERE pg_class.oid = old_table_name::regclass
  AND indisprimary;

  -- Construct arrays of table columns
  SELECT array_agg(
      CASE
        WHEN attname = ANY(old_chg_columns) THEN
          new_chg_columns[array_idx(old_chg_columns,attname::text)]
          ||' AS '||attname
        ELSE attname
      END ORDER BY attnum
    ) AS view_aliases
  , array_agg(attname ORDER BY attnum) AS old_all_columns
  , array_agg(
      CASE
        WHEN attname = ANY(old_chg_columns) THEN
          new_chg_columns[array_idx(old_chg_columns,attname::text)]
        ELSE attname
      END ORDER BY attnum
    ) AS new_all_columns
  , array_agg(pg_get_expr(adbin, adrelid)) AS default_values
  INTO view_aliases
     , old_all_columns
     , new_all_columns
     , default_values
  FROM pg_class
  JOIN pg_attribute ON (attrelid = pg_class.oid)
  LEFT JOIN pg_attrdef ON (adrelid = pg_class.oid AND adnum = pg_attribute.attnum)
  WHERE pg_class.oid = old_table_name::regclass
  AND attnum > 0 AND NOT attisdropped;

  IF NOT (old_chg_columns <@ old_all_columns) THEN
    RAISE EXCEPTION 'one or more column names in % not exist', old_chg_columns;
  END IF;
  IF EXISTS(SELECT 'x' FROM unnest(new_chg_columns) AS col
            WHERE col = ANY (old_all_columns)) THEN
    RAISE EXCEPTION 'new name conflict %', new_chg_columns;
  END IF;

  IF column_rename_only THEN
    --  When View (against a 'shadow' table) is shared between two releases,
    --+ View needs both old & new columns for access by both releases.
    view_aliases := view_aliases || new_chg_columns;
  END IF;

  IF new_chg_columns IS NOT NULL THEN
    RETURN QUERY
      SELECT format(
        E'ALTER TABLE %I RENAME %I TO %I;\n',old_table_name,o.name,n.name)
      FROM (SELECT row_number() OVER(), name
            FROM unnest(old_chg_columns) AS name) AS o
      JOIN (SELECT row_number() OVER(), name
            FROM unnest(new_chg_columns) AS name) AS n USING (row_number) ;
  END IF;
  RETURN NEXT format(
    E'ALTER TABLE %I RENAME TO %I;\n', old_table_name, new_table_name
  );
  RETURN NEXT format(
    E'CREATE VIEW %I AS\n  SELECT %s\n  FROM %I;\n'
    , old_table_name
    , CASE
        WHEN new_chg_columns IS NULL THEN '*'
        ELSE array_to_string(view_aliases, E'\n  , ')
      END
    , new_table_name
  );
  RETURN NEXT format(
    E'ALTER VIEW %I\n  %s;\n'
    , old_table_name
    , (SELECT string_agg(
        format('ALTER COLUMN %I SET DEFAULT %s'
              , col, default_values[array_idx(old_all_columns,col::text)])
        , E',\n  ')
       FROM unnest(old_all_columns) AS col
       WHERE default_values[array_idx(old_all_columns,col::text)] IS NOT NULL)
  );
  RETURN NEXT format(
    $DDL$CREATE OR REPLACE FUNCTION insteadof_%1$I_dml_fn()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $trigger$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO %2$I
    ( %5$s
    ) VALUES
    ( %6$s
    );
    RETURN NEW;
  ELSIF TG_OP = 'UPDATE' THEN
    UPDATE %2$I SET
    ( %5$s
    ) =
    ( %6$s
    ) WHERE (%4$s) = (OLD.%3$s);
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    DELETE FROM %2$I
    WHERE (%4$s) = (OLD.%3$s);
    RETURN OLD;
  END IF;
  RETURN NEW;
END; $trigger$;
$DDL$
    , old_table_name
    , new_table_name
    , old_primary_key
    , new_primary_key
    , array_to_string(new_all_columns, E'\n    , ')
    , (
        -- List construct for INSERT and UPDATE operation
        SELECT string_agg(
          CASE WHEN column_rename_only AND col = ANY(old_chg_columns) THEN
            format(E'CASE\n        '
                || E'WHEN current_setting(''switchfly.release_version'')::int >= %3$s\n        '
                || E'THEN NEW.%2$I ELSE NEW.%1$I\n      END'
                , col, new_chg_columns[array_idx(old_chg_columns,col::text)]
                , target_release)
          ELSE 'NEW.'||col
          END, E'\n    , ')
        FROM unnest(old_all_columns) AS col
      )
  );

  RETURN NEXT format(
    E'CREATE TRIGGER insteadof_%1$s_trg\n'
    ||E'  INSTEAD OF INSERT OR UPDATE OR DELETE\n'
    ||E'  ON %1$s FOR EACH ROW\n'
    ||E'  EXECUTE PROCEDURE insteadof_%1$s_dml_fn();\n'
    , old_table_name
  );
  RETURN NEXT format(E'SELECT grant_permissions(''%1$s'');\n', old_table_name);
  RETURN;
END;
$_$;


ALTER FUNCTION public.ddl2rename(names text[], target_release integer) OWNER TO postgres;




