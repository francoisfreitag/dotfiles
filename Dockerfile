FROM php:8.0-cli

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
        apt-get update && apt-get install -y \
        poppler-utils \
        python3 \
    && install-php-extensions @composer gd igbinary intl pdo_pgsql pgsql redis soap zip
