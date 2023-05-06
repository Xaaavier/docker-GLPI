FROM php:fpm-alpine3.17

LABEL Author="Xavier <xfrancois@gmx.fr>"
LABEL Maintaner="Xavier"
LABEL Release-date="2023-04-15"
LABEL Description="Dockerfile allowing a fast installation of a php-fpm server intended for the implementation of GLPI"
LABEL Version="1.0"

RUN apk update \
  && apk add --update --no-cache --virtual .build-dependencies $PHPIZE_DEPS pcre-dev ${PHPIZE_DEPS} \
  && apk add --no-cache tzdata \
  && docker-php-ext-install -j$(nproc) mysqli \
  && docker-php-ext-enable mysqli \
  && apk add --no-cache freetype freetype-dev libjpeg libjpeg-turbo-dev libpng libpng-dev \
  && docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-ext-enable gd \
  && apk add --no-cache icu icu-dev \
  && docker-php-ext-configure intl \
  && docker-php-ext-install -j$(nproc) intl \
  && docker-php-ext-enable intl \
  && docker-php-ext-install -j$(nproc) opcache \
  && docker-php-ext-enable opcache \
  && docker-php-ext-install -j$(nproc) exif \
  && docker-php-ext-enable exif \
  && apk add --no-cache libldap openldap-dev \
  && docker-php-ext-configure ldap \
  && docker-php-ext-install -j$(nproc) ldap \
  && docker-php-ext-enable ldap \
  && apk add --no-cache libzip libzip-dev \
  && docker-php-ext-install -j$(nproc) bz2 \
  && docker-php-ext-enable bz2 \
  && docker-php-ext-install -j$(nproc) zip \
  && docker-php-ext-enable zip \
  && pecl install redis \
  && docker-php-ext-enable redis \
  && apk del .build-dependencies $PHPIZE_DEPS pcre-dev ${PHPIZE_DEPS}\
  && apk del --no-cache freetype-dev libjpeg-turbo-dev libpng-dev icu-dev openldap-dev libzip-dev musl-dev \
  && rm -rf /tmp/*

EXPOSE 9000

WORKDIR /var/www/html

CMD ["php-fpm"]