#!/bin/bash

echo "####################### Main Process: $(basename $0) ###########################"

printenv

echo ">>>> Who am i: `whoami` ; UID=`id -u` ; GID=`id -g`"

#### Do some process calls here ... ####
#export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
sudo /etc/init.d/dbus start
echo DBUS_SYSTEM_BUS_ADDRESS=$DBUS_SYSTEM_BUS_ADDRESS
/usr/bin/firefox & 
/usr/bin/google-chrome --no-sandbox &

/bin/bash

tail -f /dev/null
