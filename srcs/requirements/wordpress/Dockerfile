FROM alpine:3.21


#upgrade packages in base image
RUN apk update && apk upgrade --no-cache

#install php wp mariadb 
RUN apk add --no-cache php php-fpm php-mysqli mariadb-client wget curl
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp


#manually add user and group www-data - alpine image so light weight its not configured
RUN adduser -S -H -G www-data www-data 2>/dev/null || true

#overwrite the config with our personalized one
COPY /conf/www.conf /etc/php/8.2/fpm/pool.d/
COPY ./tools/entry_wp.sh /
RUN chmod +x /entry_wp.sh
# WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/entry_wp.sh"]
