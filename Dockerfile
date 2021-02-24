FROM php:7.4-fpm

RUN set -eux; \
    apt update; \
    apt install -y \
        wget \
        libzip-dev \
        zip \
        vim \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libpq-dev; \

     php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
     php ./composer-setup.php; \
     mv ./composer.phar /usr/sbin/composer; \

    pecl install xdebug-2.9.7; \
    rm -rf /var/lib/apt/lists/*; \

    docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/; \
    docker-php-ext-install gd; \
    docker-php-ext-enable xdebug; \
    docker-php-ext-configure zip; \
    docker-php-ext-install zip; \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql; \
    docker-php-ext-install pdo pdo_mysql
