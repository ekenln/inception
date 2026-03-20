COMPOSE = docker compose -f srcs/docker-compose.yml
DATA_DIR = /home/eeklund/data

all: create_dirs
	@${COMPOSE} up --build -d

down:
	@${COMPOSE} down

clean: down
	docker system prune -af

fclean: clean
	@${COMPOSE} down -v
	sudo rm -rf ${DATA_DIR}/*

create_dirs:
	@mkdir -p ${DATA_DIR}/mariadb
	@mkdir -p ${DATA_DIR}/wordpress

logs:
	@${COMPOSE} logs -f

logs-wp:
	@${COMPOSE} logs wordpress

logs-mbd:
	@${COMPOSE} logs mariadb

re: clean all

.PHONY: all down clean fclean re create_dirs logs logs-wp logs-mdb