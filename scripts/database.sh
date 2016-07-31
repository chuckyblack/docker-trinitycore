#!/bin/bash

set -e
set -x

cd  /opt/trinitycore

# download TDB
TDB=TDB_full_6.04_2016_04_11
wget --no-check-certificate https://github.com/TrinityCore/TrinityCore/releases/download/TDB6.04/${TDB}.7z
p7zip -d ${TDB}.7z

# start mysql and import data
mysqld_safe &
mysql_pid=$!
mysqladmin --silent --wait=30 ping || exit 1
mysql < sources/sql/create/create_mysql.sql
mysql world < ${TDB}/TDB_world_*.sql
mysql hotfixes < ${TDB}/TDB_hotfixes_*.sql
mysqladmin shutdown
wait $mysql_pid

rm -rf ${TDB}

