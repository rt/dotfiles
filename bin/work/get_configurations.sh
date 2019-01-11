#! /usr/bin/env bash

db=$1
category=$2

read -r -d '' sql <<"EOF"
SELECT 
  configuration.config_name, 
  configuration_category.category_name,   
  configuration.live_value, 
  configuration.test_value, 
  configuration.cobrand_name, 
  configuration.agency_id, 
  configuration.cobrand_name 
FROM
  configuration_description 
INNER JOIN 
  configuration_description_category_mapping ON
  configuration_description_category_mapping.configuration_description_id = configuration_description.id
INNER JOIN 
  configuration_category ON
  configuration_description_category_mapping.configuration_category_id = configuration_category.id
INNER JOIN configuration ON
  configuration.config_name = configuration_description.config_name
<where>;
EOF

whereClause=;
if [ ! -z "$1" ]; then
  whereClause=" WHERE configuration_category.category_name = '$category'"
fi

sql=${sql/<where>/$whereClause}

psql -U postgres -h localhost -qtA -d qaone -c "$sql"
