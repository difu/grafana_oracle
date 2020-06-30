#!/bin/bash
[ -z "$PROMETHEUS_SCHEMA" ]                 && PROMETHEUS_SCHEMA="prometheus"
[ -z "$PROMETHEUS_SCHEMA_PASSWORD" ]        && PROMETHEUS_SCHEMA_PASSWORD="prometheus"
[ -z "$ORACLE_SYS_PASSWORD" ]               && ORACLE_SYS_PASSWORD="sys"
[ -z "$SQLPLUS_BIN"]                        && SQLPLUS_BIN="/u01/app/oracle/product/instantclient_19_6/sqlplus"
[ -z "$DB_PORT"]                            && DB_PORT="1521"
[ -z "$DB_SERVICE"]                         && DB_SERVICE="ORCLPDB1"
[ -z "$DB_HOST"]                            && DB_HOST="localhost"
