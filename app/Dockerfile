FROM php:7.4-apache

LABEL maintainer="hemantkumar.goswami@homeoffice.gsi.gov.uk"

RUN set -ex; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libfreetype6-dev \
		libjpeg-dev \
		libldap2-dev \
		libpng-dev \
		libzip-dev \
		libldap-common \
		libssl1.1 \
		openssl \
		libzstd1 \
	; \
	\
	debMultiarch="$(dpkg-architecture --query DEB_BUILD_MULTIARCH)"; \
	docker-php-ext-configure gd --with-freetype --with-jpeg; \
	docker-php-ext-configure ldap --with-libdir="lib/$debMultiarch"; \
	docker-php-ext-install -j "$(nproc)" \
		gd \
		ldap \
		mysqli \
		opcache \
		pdo_mysql \
		zip \
	; \
	\
# pecl will claim success even if one install fails, so we need to perform each install separately
	pecl install APCu-5.1.19; \
	pecl install redis-5.3.1; \
	\
	docker-php-ext-enable \
		apcu \
		redis \
	; \
	\
# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark; \
	ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
		| awk '/=>/ { print $3 }' \
		| sort -u \
		| xargs -r dpkg-query -S \
		| cut -d: -f1 \
		| sort -u \
		| xargs -rt apt-mark manual; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

ENV MATOMO_VERSION 4.2.1

RUN set -ex; \
	fetchDeps=" \
		dirmngr \
		gnupg \
	"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		$fetchDeps \
	; \
	\
	curl -fsSL -o matomo.tar.gz \
		"https://builds.matomo.org/matomo-${MATOMO_VERSION}.tar.gz"; \
	curl -fsSL -o matomo.tar.gz.asc \
		"https://builds.matomo.org/matomo-${MATOMO_VERSION}.tar.gz.asc"; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys 814E346FA01A20DBB04B6807B5DBD5925590A237; \
	gpg --batch --verify matomo.tar.gz.asc matomo.tar.gz; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" matomo.tar.gz.asc; \
	tar -xzf matomo.tar.gz -C /usr/src/; \
	rm matomo.tar.gz; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps; \
	rm -rf /var/lib/apt/lists/*

COPY matomo.php.ini /usr/local/etc/php/conf.d/php-matomo.ini

COPY matomo.entrypoint.sh /entrypoint.sh
RUN chmod 0755 /entrypoint.sh

RUN apt update && apt-get install default-mysql-client -y

ENV USERMAP_UID 33

RUN sed -i -e 's/:80/:9000/g' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i -e 's/Listen 80/Listen 9000/g' /etc/apache2/ports.conf

RUN chown -R $(id -nu ${USERMAP_UID}):$(id -nu ${USERMAP_UID}) /var/www/html
COPY config.ini.php /usr/src/piwik/config
COPY config.ini.php /var/www/html/config/config.ini.php
COPY entrypoint.sh /entrypoint-wrap.sh

RUN chown -R $(id -nu ${USERMAP_UID}):$(id -nu ${USERMAP_UID}) /var/www/html

ENTRYPOINT ["/entrypoint-wrap.sh"]
USER ${USERMAP_UID}
CMD ["apache2-foreground"]
