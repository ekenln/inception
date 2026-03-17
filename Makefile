COMPOSE = docker compose -f src/docker-compose.yml

all:
	@${COMPOSE} up --build -d

down:
	@${COMPOSE} down -v

clean:
	@${COMPOSE} down -v
	docker system prune -af

fclean: clean
	rm -rf /home/eeklund/data/mariadb/*
	rm -rf /home/eeklund/data/wordpress/*

create_dirs:
	@mkdir -p /home/eeklund/data/mariadb
	@mkdir -p /home/eeklund/data/wordpress

logs:
	@${COMPOSE} logs -f

logs-wp:
	@${COMPOSE} logs wordpress

logs-mbd:
	@${COMPOSE} logs mariadb

re: clean all

.PHONY: all down clean fclean re create_dirs logs logs-wp logs-mdb