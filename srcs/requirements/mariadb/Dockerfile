FROM alpine:3.21

#upgrade packages in base image
RUN apk --no-cache upgrade

#install mariadb and mariadb client
RUN apk add --no-cache mariadb mariadb-client

#copy config
COPY conf/mariadb.conf ./etc/mariadb.conf

#create directory for database & set permissions for the database directory
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

#for internal network communication
EXPOSE 3306

#command to run mariaDB

