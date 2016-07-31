#!/bin/bash

service	mysql start
sleep 2
cd /opt/trinitycore/bin
./bnetserver &

source /scripts/infiniteLoop.sh
