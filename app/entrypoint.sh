#!/bin/bash

set -e
/entrypoint.sh

sed -i -e "s/{PIWIK_MYSQL_HOST}/$PIWIK_MYSQL_HOST/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_MYSQL_PORT}/$PIWIK_MYSQL_PORT/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_MYSQL_USER}/$PIWIK_MYSQL_USER/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_MYSQL_PASSWORD}/$PIWIK_MYSQL_PASSWORD/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_MYSQL_DBNAME}/$PIWIK_MYSQL_DBNAME/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_APP_HOST}/$PIWIK_APP_HOST/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_APP_SALT}/$PIWIK_APP_SALT/" /var/www/html/config/config.ini.php
sed -i -e "s/{PIWIK_MYSQL_DB_PREFIX}/$PIWIK_MYSQL_DB_PREFIX/" /var/www/html/config/config.ini.php

exec "$@"
