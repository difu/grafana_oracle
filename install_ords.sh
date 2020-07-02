#/bin/bash

. "$(dirname $0)/env.sh"


echo "Creating directory conf " ${ORDS_CONF_DIR}
mkdir -p ${ORDS_CONF_DIR}

./create_ords_configs.py

java -jar ${ORDS_HOME}/ords.war configdir ${ORDS_CONF_DIR}

echo "Install ORDS"
java -jar ${ORDS_HOME}/ords.war install --parameterFile ${ORDS_CONF_DIR}/ords_params.properties --silent

echo "Setup database"
java -jar ${ORDS_HOME}/ords.war setup --database prometheus_metrics --parameterFile ${ORDS_CONF_DIR}/db_params.properties --silent

echo "Create mapping"
java -jar ${ORDS_HOME}/ords.war map-url --type base-path /prometheus_metrics prometheus_metrics
