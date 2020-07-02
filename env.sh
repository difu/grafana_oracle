#!/bin/bash
[ -z "$PROMETHEUS_SCHEMA" ]                 && export PROMETHEUS_SCHEMA="prometheus"
[ -z "$PROMETHEUS_SCHEMA_PASSWORD" ]        && export PROMETHEUS_SCHEMA_PASSWORD="prometheus"
[ -z "$ORACLE_SYS_PASSWORD" ]               && export ORACLE_SYS_PASSWORD="sys"
[ -z "$SQLPLUS_BIN"]                        && export SQLPLUS_BIN="/u01/app/oracle/product/instantclient_19_6/sqlplus"
[ -z "$DB_PORT"]                            && export DB_PORT="1521"
[ -z "$DB_SERVICE"]                         && export DB_SERVICE="ORCLPDB1"
[ -z "$DB_HOST"]                            && export DB_HOST="localhost"
[ -z "$ORDS_HOME" ]                         && export ORDS_HOME="/u01/app/oracle/product/ords-19.4"
[ -z "$ORDS_CONF_DIR" ]                     && export ORDS_CONF_DIR=${ORDS_HOME}/conf

