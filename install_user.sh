#/bin/bash

. "$(dirname $0)/env.sh"

$SQLPLUS_BIN sys/${ORACLE_SYS_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_SERVICE} as sysdba << __EOF__
    create user ${PROMETHEUS_SCHEMA} identified by ${PROMETHEUS_SCHEMA_PASSWORD};
    grant connect, select any dictionary, create procedure to prometheus;
__EOF__
