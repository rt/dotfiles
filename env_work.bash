alias work.clear.coverage="workClearCoverage"
alias work.fe.health.check="fe_health_check"
alias work.get_translations="get_translations"
alias work.menu="menu"

export DB_DATA_DIR=postgresql
export GRADLE_OPTS='-Xms3G -Xmx3G -verbose:gc'

ctags_switchfly() {
  ctags -R --language-force=java -f .tags core-webapp/src/ webapp-spring/src/ webcf/src/ web-common/src/ core/src/ common/src/
}


alias wpl="find ~/dev/repos/dev/core-webapp/src/main/webapp/resources/ -name package-lock.json -maxdepth  2 | xargs rm"
alias wnm="find ~/dev/repos/dev/core-webapp/src/main/webapp/resources/ -name node_modules -maxdepth  2 -type dir | xargs rm -rf"


workClearCoverage() {
  for APP in shopping encore encoreworkspace admin mechandise mobile utilities 
  do
    cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/$APP/scripts 
    rm -rf coverage HeadlessChrome*
    rm *.xml
    cd -
  done
}

fe_health_check() {
  echo "Line count (scripts)"
  find scripts/ -name '*.js' | xargs wc -l | sort

  echo "Line count (test)"
  find test/ -name '*.js' | xargs wc -l | sort

  echo "Ember.run count (scripts)"
  grep Ember.run -rC 0 scripts/ | wc -l;

  echo "Ember.run count (test)"
  grep Ember.run -rC 0 test/ | wc -l;

  echo "Ember.observes count (scripts)"
  grep '.observes(' -rC 0 scripts/ | wc -l;

  echo "Ember.observes count (tests)"
  grep '.observes(' -rC 0 test/ | wc -l;

  echo "Ember.lookup count (scripts)"
  grep 'lookup' -rC 0 scripts/ | wc -l;
}

get_translations() {
  version=$(get_release_version);
  psql -U postgres -h localhost -qtA -d "ezrez_shared_$version" -c "SELECT name FROM translations;"
}

##### menu #####

invalid_input () {
  local actual=$1
  echo "Invalid input '$actual''" >&2
  exit 1
}

menu() {
  clear 
  echo "
  Please Select:
  1. Get Table Definition          ( tabdef)
  2. Get Table Data                ( tabdata)
  3. Get Table Relations( get_table_relations)
  4. Get Configuration By Category ( confbycat)
  0. Quit
  "

  read -p "Enter selection [0-4] > " REPLY
  if [[ $REPLY =~ ^[0-4]$ ]]; then
    if [[ $REPLY == 0 ]]; then
      echo "Program terminated."
      exit
    fi
    if [[ $REPLY == 1 ]]; then
      read -p "Please enter db (ie qaone, shared) -> " db

      # input is empty (invalid)
      [[ -z $db ]] && invalid_input $db

      tabdef $db
      exit
    fi
    if [[ $REPLY == 2 ]]; then
      read -p "Please enter db (ie qaone, shared) -> " db
      
      # input is empty (invalid)
      [[ -z $db ]] && invalid_input $db

      tabdata $db
      exit
    fi
    if [[ $REPLY == 3 ]]; then
      read -p "Please enter keyword (ie loyalty_segmentation) -> " keyword

      # input is empty (invalid)
      [[ -z $keyword ]] && invalid_input $keyword

      psql.showTableRelations $keyword
      exit
    fi
    if [[ $REPLY == 4 ]]; then
      confbycat
      exit
    fi
  fi
}

confbycat() {
  db=
  if [[ $1 = "shared" ]]; then
    db="ezrez_shared_$(get_release_version)"
  else
    db="qaone"
  fi

  cat="$(get_configuration_categories $db | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  if [[ -n $cat ]]; then
    get_configurations $db $cat
  fi
}

get_configuration_categories() {
  #filename=sql/select_config_categories.sql
  db=$1

  read -r -d '' sql <<"EOF"
SELECT category_name FROM configuration_category;
EOF

  psql -U postgres -h localhost -qtA -d "$db" -c "$sql"
}

get_configurations() {
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
}

tabdata() {
  db=
  if [[ $1 = "shared" ]]; then
    db="ezrez_shared_$(get_release_version)"
  else
    db="qaone"
  fi

  file="$(psql.showTables $db | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  if [[ -n $file ]]; then
    psql.getTableData $db $file
  fi
}

tabdef() {
  db=
  if [[ $1 = "shared" ]]; then
    db="ezrez_shared_$(get_release_version)"
  else
    db="qaone"
  fi

  #db="$(psql.showDatabases | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  file="$(psql.showTables $db | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  if [[ -n $file ]]; then
    psql.getTableDefinition $db $file
  fi
}

get_release_version() {
  format=$1

  # Get test for current file
  root=~/dev/repos/dev

  release=
  while read line; do
    if [[ $line = *"<version>"*"</version>"* ]]; then
      release=${line/\<version\>/}
      release=${release/\<\/version\>/}
      #remove white spaces
      release="$(echo -e "${release}" | tr -d '[:space:]')"
      break;
    fi
  done <$root/pom.xml

  case $format in
    dot)
      major=${release:0:2}
      minor=${release: -1} #must be preceeded by space
      echo "$major.$minor"
      ;;
    *)
      echo "$release"
      ;;
  esac
}
