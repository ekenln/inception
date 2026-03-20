# Developer docs

## Prerequisites
 
- A Linux machine or VM with Docker and Docker Compose installed
- `sudo` access for managing `/etc/hosts` and data directories
- `make` installed


## Configuration
 
All credentials and environment-specific values are stored in `src/.env`. Create this file before building:
 
```env
DOMAIN_NAME=<domain_name>
TITLE=inception

DATABASE_NAME=wp_db
MYSQL_USER=youruser
MYSQL_PASSWORD=yourpassword
MYSQL_ROOT_PASSWORD=yourrootpassword
 
WP_ADMIN=admin
WP_ADMIN_EMAIL=admin@example.com
WP_ADMIN_PASSWORD=adminpass
 
WP_USER=user
WP_USER_EMAIL=user@example.com
WP_USER_PASSWORD=userpass
```

- The domain name of your choice (defined in the .env file) must resolve to `127.0.0.1`

Add the domain to your `/etc/hosts`:
```bash
echo "127.0.0.1 <domain_name>" | sudo tee -a /etc/hosts
```

## Building and launching 

### Start the project
```bash
make
```
This will:
1. Create the data directories at `/home/eeklund/data/mariadb` and `/home/eeklund/data/wordpress`
2. Build all Docker images from their Dockerfiles
3. Start all containers in detached mode
 
### Stop and remove containers and volumes
```bash
make down
```
 
### Rebuild from scratch
```bash
make re
```
calls make down and all so the data will still be there
 
### Full cleanup (removes all images, containers, and data)
```bash
make fclean
```
> This permanently deletes all data in `/home/eeklund/data/`.
 
---

## Managing Containers

### Check running containers
```bash
docker compose -f src/docker-compose.yml ps
```

### View live logs for all services
```bash
make logs
```
 
### View logs for a specific service
```bash
make logs-wp    # WordPress
make logs-mbd   # MariaDB
```
 
### Inspect a running container
```bash
docker inspect nginx
docker inspect wordpress
docker inspect mariadb
```

### Inspect volumes
```bash
docker volume inspect
```

### Open a shell inside a container
```bash
docker exec -it nginx sh
docker exec -it wordpress bash
docker exec -it mariadb bash
```

### View docker network
```bash
docker network ls
```

## Data Persistence
 
All persistent data is stored on the host machine under `/home/eeklund/data/`

These paths are mounted into the containers via named volumes defined in `docker-compose.yml`

```yaml
volumes:
  db:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /home/eeklund/data/mariadb
  wp_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /home/eeklund/data/wordpress
```
 
Data persists across `make down` and container restarts. Only `make fclean` removes it.
 
---
 
## SSL Certificate
 
The SSL certificate is self-signed and generated automatically during the NGINX image build using OpenSSL:
 
```bash
openssl req -x509 -nodes \
  -out /etc/nginx/ssl/inception.crt \
  -keyout /etc/nginx/ssl/inception.key \
  -subj "/C=NL/ST=Amsterdam/O=42/OU=42/CN=eeklund.42.fr/UID=eeklund"
```
 
Browsers will show a security warning for self-signed certificates — this is expected. Accept the warning to proceed.
