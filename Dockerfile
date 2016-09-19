FROM alpine:edge
WORKDIR /var/www/html
EXPOSE 9000
RUN apk add --no-cache \
      php7 \
      php7-fpm \
      php7-iconv \
      php7-json \
      php7-opcache \
      php7-openssl \
      php7-phar \
    && wget http://getcomposer.org/installer \
    && php7 installer -- --install-dir=/usr/bin --filename=composer \
    && rm installer \
    && { \
      echo '[global]'; \
      echo 'error_log = /proc/self/fd/2'; \
      echo 'daemonize = no'; \
      echo '[www]'; \
      echo 'user = nobody'; \
      echo 'group = nobody'; \
      echo 'listen = 0.0.0.0:9000'; \
      echo 'pm = dynamic'; \
      echo 'pm.max_children = 5'; \
      echo 'pm.start_servers = 1'; \
      echo 'pm.min_spare_servers = 1'; \
      echo 'pm.max_spare_servers = 3'; \
      echo 'catch_workers_output = yes'; \
    } > /etc/php7/php-fpm.d/www.conf
#COPY composer.json .
#RUN php7 /usr/bin/composer --no-interaction install && rm composer.json
#CMD ["php-fpm7"]