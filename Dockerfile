FROM alpine:edge
WORKDIR /var/www/html
RUN apk add --no-cache \
      php7-json \
      php7-openssl \
      php7-iconv \
      php7-phar \
      php7 \
    && wget http://getcomposer.org/installer \
    && php7 installer -- --install-dir=/usr/bin --filename=composer \
    && rm installer
#COPY composer.json .
#RUN php7 /usr/bin/composer --no-interaction install && rm composer.json
