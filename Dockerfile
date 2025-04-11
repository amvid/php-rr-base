FROM php:8.3.19-cli-alpine3.20

RUN --mount=type=bind,from=mlocati/php-extension-installer:2.7,source=/usr/bin/install-php-extensions,target=/usr/local/bin/install-php-extensions \
  install-php-extensions pdo pdo_mysql zip opcache xsl dom exif intl pcntl bcmath sockets redis gd && \
  apk add --no-cache git unzip && \
  apk del --no-cache ${PHPIZE_DEPS} ${BUILD_DEPENDS}

WORKDIR /app

ENV COMPOSER_ALLOW_SUPERUSER=1
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY --from=ghcr.io/roadrunner-server/roadrunner:2024.3.4 /usr/bin/rr /usr/bin/rr

