#/bin/bash

. "$(dirname $0)/env.sh"

$SQLPLUS_BIN ${PROMETHEUS_SCHEMA}/${PROMETHEUS_SCHEMA_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_SERVICE} @create_metrics_proc.sql