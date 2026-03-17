all:
	@docker-compose -f srcs/docker-compose.yml up

wp:
	@docker compose -f srcs/docker-compose.yml up wordpress

mdb:
	@docker compose -f srcs/docker-compose.yml up mariadb


logs-wp:
	@docker-compose -f srcs/docker-compose.yml logs wordpress

logs-mbd:
	@docker-compose -f srcs/docker-compose.yml logs mariadb

down:
	@docker compose -f srcs/docker-compose.yml down -v

clean:
	@docker compose -f srcs/docker-compose.yml down -v

re: clean all