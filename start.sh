#!/bin/bash -e
: "${SALT_USE:=master}"
: "${SALT_NAME:=master}"
: "${LOG_LEVEL:=info}"
: "${OPTIONS:=}"
echo `SALT_NAME` > /etc/salt/minion_id
echo "INFO: Starting salt-$SALT_USE with log level $LOG_LEVEL with hostname $SALT_NAME"
sudo /usr/bin/salt-$SALT_USE --log-level=$LOG_LEVEL $OPTIONS
