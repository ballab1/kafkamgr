#!/bin/bash

__file="${KM_HOME}/conf/routes"
if [ "$KM_HTTP_CONTEXT" != '/' ] ; then
    term.log "    updating '${__file}' use HTTP context '$KM_HTTP_CONTEXT'\n" 'white'
    sed -Ei \
        -e "s|^(\w+\s+)/|\1${KM_HTTP_CONTEXT}/|g" \
           "$__file"
fi

[ -e "${KM_HOME}/RUNNING_PID" ] && rm "${KM_HOME}/RUNNING_PID"

[ "${APPLICATION_SECRET:-}" ] || lib.file_env 'APPLICATION_SECRET'
[ "${KAFKA_MANAGER_PASSWORD:-}" ] || lib.file_env 'KAFKA_MANAGER_PASSWORD'
echo
echo 'Kafka-Manager configuration'
echo "    APPLICATION_SECRET:         ${APPLICATION_SECRET:-}"
echo "    KM_HTTP_CONTEXT:            ${KM_HTTP_CONTEXT:-}"
echo "    ZK_HOSTS:                   ${ZK_HOSTS:-}"
echo "    BASE_ZK_PATH:               ${BASE_ZK_PATH:-}"
echo "    KM_HOME:                    ${KM_HOME:-}"
echo "    KAFKA_MANAGER_LOGLEVEL:     ${KAFKA_MANAGER_LOGLEVEL:-}"
echo "    KAFKA_MANAGER_AUTH_ENABLED: ${KAFKA_MANAGER_AUTH_ENABLED:-}"
echo "    KAFKA_MANAGER_USERNAME:     ${KAFKA_MANAGER_USERNAME:-}"
echo "    KAFKA_MANAGER_PASSWORD:     ${KAFKA_MANAGER_PASSWORD:-}"
echo "    CONSUMER_PROPERTIES_FILE:   ${CONSUMER_PROPERTIES_FILE:-}"
echo
echo
echo "Configuration file: '$KM_CONFIGFILE'"
while read ln; do
    printf '    %s\n' "$ln"
done < <(cat "$KM_CONFIGFILE")
echo
echo
