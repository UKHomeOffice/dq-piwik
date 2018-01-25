FROM busybox
COPY --from=library/piwik:apache / .
WORKDIR /var/www/html
RUN cp -r /usr/src/piwik/* /var/www/html/
COPY php.ini /usr/local/etc/php/php.ini
COPY config.ini.php /var/www/html/config/config.ini.php

RUN chown -R www-data:www-data /var/www/html /var/log/apache2 /var/run/apache2 /var/lock/apache2

RUN sed -i -e 's/:80/:9000/g' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i -e 's/Listen 80/Listen 9000/g' /etc/apache2/ports.conf

#RUN sed -i -e "s/{PIWIK_MYSQL_HOST}/$PIWIK_MYSQL_HOST/" /var/www/html/config/config.ini.php
#RUN sed -i -e "s/{PIWIK_MYSQL_USER}/$PIWIK_MYSQL_USER/" /var/www/html/config/config.ini.php
#RUN sed -i -e "s/{PIWIK_MYSQL_PASSWORD}/$PIWIK_MYSQL_PASSWORD/" /var/www/html/config/config.ini.php
#RUN sed -i -e "s/{PIWIK_MYSQL_DBNAME}/$PIWIK_MYSQL_DBNAME/" /var/www/html/config/config.ini.php
#RUN sed -i -e "s/{PIWIK_APP_HOST}/$PIWIK_APP_HOST/" /var/www/html/config/config.ini.php
#RUN sed -i -e "s/{PIWIK_APP_SALT}/$PIWIK_APP_SALT/" /var/www/html/config/config.ini.php


USER www-data

CMD ["apache2-foreground"]
