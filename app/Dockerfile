FROM piwik:apache

RUN sed -i -e 's/:80/:9000/g' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i -e 's/Listen 80/Listen 9000/g' /etc/apache2/ports.conf

COPY config.ini.php /usr/src/piwik/config
COPY entrypoint.sh /entrypoint-wrap.sh
ENTRYPOINT ["/entrypoint-wrap.sh"]
USER www-data
CMD ["apache2-foreground"]s
