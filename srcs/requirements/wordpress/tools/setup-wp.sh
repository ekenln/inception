#!/bin/sh

set -x

mkdir -p /var/www/wordpress
cd /var/www/wordpress

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

if [ ! -f wp-login.php ]; then
    wp core download --allow-root
fi

until mysqladmin ping -h mariadb -u$MYSQL_USER -p$MYSQL_PASSWORD --silent; do
    sleep 2
done

if [ ! -f wp-config.php ]; then
	wp config create --allow-root \
					--dbname=$DATABASE_NAME \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=mariadb

	wp core install --allow-root \
				--url=$DOMAIN_NAME \
				--title=$TITLE \
				--admin_user=$WP_ADMIN \
				--admin_password=$WP_ADMIN_PASSWORD \
				--admin_email=$WP_ADMIN_EMAIL \
				--skip-email

	wp user create --allow-root "${WP_USER}" "${WP_USER_EMAIL}" \
				--user_pass=$WP_USER_PASSWORD \
				--role=editor
fi

echo "starting WordPress"
exec php-fpm8.2 -F
