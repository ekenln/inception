FROM alpine:3.21

#upgrade packages in base image
RUN apk update && apk upgrade --no-cache

#install mariadb and mariadb client
RUN apk add --no-cache mariadb mariadb-client

#create directory for database & set permissions for the database directory
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld


COPY conf/my.cnf /etc/my.cnf

COPY tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh

VOLUME ["/var/lib/mysql"]

#for internal network communication
EXPOSE 3306

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["mariadbd", "--user=mysql", "--datadir=/var/lib/mysql"]
