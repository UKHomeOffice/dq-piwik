FROM matomo:apache
LABEL maintainer="hemantkumar.goswami@homeoffice.gsi.gov.uk"

ENV USERMAP_UID 33

RUN sed -i -e 's/:80/:9000/g' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i -e 's/Listen 80/Listen 9000/g' /etc/apache2/ports.conf

COPY config.ini.php /usr/src/piwik/config
COPY entrypoint.sh /entrypoint-wrap.sh
ENTRYPOINT ["/entrypoint-wrap.sh"]
USER ${USERMAP_UID}

CMD ["apache2-foreground"]
