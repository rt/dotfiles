#! /usr/bin/env bash
version=$('get_release_version.sh');
psql -U postgres -h localhost -qtA -d "ezrez_shared_$version" -c "SELECT name FROM translations;"

