#!/bin/bash
# don't use /bin/sh, as it'll break influxdb's own entry script

set -e

vars="DOCKER_INFLUXDB_INIT_MODE DOCKER_INFLUXDB_INIT_USERNAME DOCKER_INFLUXDB_INIT_PASSWORD DOCKER_INFLUXDB_INIT_ORG DOCKER_INFLUXDB_INIT_BUCKET DOCKER_INFLUXDB_INIT_RETENTION DOCKER_INFLUXDB_INIT_ADMIN_TOKEN"

for var in $vars; do
  eval val="\$$var"
  eval val_file="\$${var}_FILE"
  if [ -z "$val" -a -n "$val_file" ]; then
    export "$var"=$(cat "$val_file")
  fi
done

. /entrypoint.sh
