#! /usr/bin/env bash

db=
if [[ $1 = "shared" ]]; then
  db="ezrez_shared_$(get_release_version.sh)"
else
  db="qaone"
fi

file="$(show_tables.sh $db | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

if [[ -n $file ]]; then
  get_table_data.sh $db $file
fi
