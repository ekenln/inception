FROM debian:bookworm

RUN apt update -y && \
	apt upgrade -y && \
	apt install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/setup-mariadb.sh /usr/local/bin/setup-mariadb.sh

RUN chmod +x /usr/local/bin/setup-mariadb.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/setup-mariadb.sh" ]