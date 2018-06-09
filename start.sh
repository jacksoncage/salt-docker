#!/bin/bash

# Variables from environement
: "${SALT_USE:=master}"
: "${SALT_NAME:=master}"
: "${LOG_LEVEL:=info}"
: "${OPTIONS:=}"

# Set minion id
echo $SALT_NAME > /etc/salt/minion_id

# If salt master also start minion in background
if [ $SALT_USE == "master" ]; then
  echo "INFO: Starting salt-minion and auto connect to salt-master"
  service salt-minion start
fi

# Set salt grains
if [ ! -z "$SALT_GRAINS" ]; then
  echo "INFO: Set grains on $SALT_NAME to: $SALT_GRAINS"
  echo $SALT_GRAINS > /etc/salt/grains
fi

# Start salt-$SALT_USE
echo "INFO: Starting salt-$SALT_USE with log level $LOG_LEVEL with hostname $SALT_NAME"
/usr/bin/salt-$SALT_USE --log-level=$LOG_LEVEL $OPTIONS
