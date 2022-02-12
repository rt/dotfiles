#!/bin/bash
set -e -x
export DEBIAN_FRONTEND=noninteractive

apt-get update && apt-get upgrade -y
apt-get -y install docker.io
docker run pebble/migrate:${COMMIT} up dbUrl=postgres://pebble:remira99@${DB-HOST}:5433/skeleton

docker run -e "DYNAMO_ENDPOINT_URL=https://dynamodb.us-west-2.amazonaws.com" pebble/migrate-dynamodb:${COMMIT} 

#by setting the following you can kill the instance on done
#--instance-initiated-shutdown-behavior terminate 
#shutdown -h now

