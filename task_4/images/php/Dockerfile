# Для начала указываем исходный образ, он будет использован как основа
FROM php:7.4-fpm-alpine3.15
RUN apk update && apk add \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        && docker-php-ext-install mysqli \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd
WORKDIR /var/www
CMD ["php-fpm"]
