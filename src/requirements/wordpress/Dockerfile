FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt-get install -y wget

RUN apt-get install -y	wget \
php \
php-fpm \
php-mysql \
mariadb-client

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY ./tools/setup-wp.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/wordpress.sh" ]