#!/bin/sh

if [ ! -d /var/lib/mysql/${DATABASE_NAME} ]; then
	service mariadb start;

	until mysqladmin ping; do
		sleep 1
	done

	mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${DATABASE_NAME}\`;"
	mysql -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON \`${DATABASE_NAME}\`.* TO '${MYSQL_USER}'@'%';"
	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
	mysql -u root -e "FLUSH PRIVILEGES;"

	mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown;
fi

echo "Starting mariaDB"
exec mysqld_safe
