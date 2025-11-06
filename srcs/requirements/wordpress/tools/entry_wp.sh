#!/bin/sh

trap "exit" TERM
set -e

mkdir -p /var/www/html

chown -R www-data:www-data /var/www/html

cd /var/www/html

if [ ! -f wp-config.php ]; then
	wget https://wordpress.org/latest.tar.gz 
	tar -xf latest.tar.gz 
	mv wordpress/* /var/www/html/
	rm -rf latest.tar.gz wordpress


	mv wp-config-sample.php wp-config.php

	echo "Waiting for MariaDB..."
	until mariadb -h "${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e "SELECT 1;" &> /dev/null
	do
		sleep 2
	done

	sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
	sed -i "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
	sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
	sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php

fi
echo "hello there"
exec php-fpm83 -F