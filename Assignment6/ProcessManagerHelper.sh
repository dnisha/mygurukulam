#!/bin/bash

register () {

    $TOUCH ${SERVICE_FILE}
    $AWK -v script_path="$PATH" -v script_alias="$ALIAS" '{gsub(/alias/, script_alias); gsub(/path/, script_path); print}' ${TEMPLATE_FILE} > ${SERVICE_FILE}
    $SUDO $MV ${SERVICE_FILE} "/usr/lib/systemd/system"
    $SUDO $SYSTEMCTL daemon-reload 
    echo "${SERVICE_FILE}" >> ${DB_FILE}

}