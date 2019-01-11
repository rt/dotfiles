#! /usr/bin/env bash

psql -U postgres -h localhost -qtA -d ezrez_shared_182 -c "SELECT name, translations, type FROM translations;"
#psql -U postgres -h localhost -qtA -d qaone -c "SELECT name, translations, type FROM translations;"

