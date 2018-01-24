#!/bin/bash
set -e

if [ ! -e piwik.php ]; then
	tar cf - --one-file-system -C /usr/src/piwik . | tar xf -
	chown -R www-data .
fi

DBHOST=`echo $PIWIK_MYSQL_HOST`
DBUSER=`echo $PIWIK_MYSQL_USER`
DBPASSWORD=`echo $PIWIK_MYSQL_PASSWORD`
DBNAME=`echo $PIWIK_MYSQL_DBNAME`
APPHOST=`echo $PIWIK_APP_HOST`
APPSALT=`echo $PIWIK_APP_SALT`


sed -i -e "s/{PIWIK_MYSQL_HOST}/$DBHOST/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_MYSQL_USER}/$DBUSER/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_MYSQL_PASSWORD}/$DBPASSWORD/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_MYSQL_DBNAME}/$DBNAME/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_APP_HOST}/$APPHOST/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_APP_SALT}/$APPSALT/" /var/www/html/config/config.ini.php

exec "$@"
