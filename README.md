*This project has been created as part of the 42 curriculum by eeklund.*

# Inception

## Description

The subject describes it like this: "This project aims to broaden your knowledge of system administration by using Docker.
You will virtualize several Docker images, creating them in your new personal virtual
machine."

So the goal is to set up a small infrastructure composed of multiple services running in separate Docker containers, all orchestrated with Docker Compose and run in a Virtual machine.

The infrastructure contains:
- **NGINX** - serves as the only entrypoint, handling https traffic on port 443 with a self signed certificate TLSv1.3

- **WordPress** — a PHP-FPM application giving a WordPress site

- **MariaDB** - the database, storing the WordPress data such as users, comments and posts.

All images are written by me using debian:bookworm as base image.

## Design choices

### Virtual Machine vs Docker
A virtual machine is a simulated computer system. It does not have access to the host system's operating system, files or hardware. Running a VM involves installing an entire OS. This makes them heavy, slow to start, and resource-intensive. Docker containers, on the other hand, share the host's kernel and isolate only the application layer.  This makes them lightweight, fast to start, and much more efficient in terms of resource usage. For a project like Inception, Docker is ideal because each service (nginx, wordpress, mariadb) can be isolated, reproducible, and easily networked together.

### Secrets vs Environment Variables
Environment variables are simple key-value pairs passed into a container at runtime. They are easy to use but can be exposed through `docker inspect`, logs, or shell history. Docker Secrets are a more secure alternative — they are stored encrypted in Docker's internal store and mounted as files inside the container, never exposed as environment variables. For this project, `.env` files are used for simplicity, but in a production environment Docker Secrets would be the preferred approach for sensitive values like passwords.

### Docker Network vs Host Network
With a docker network and communication using the services names as hostnames, the container network then becomes completely isolated from the host, which is safer. Host networking does not containerize the containers' network and you can access the thorugh the host network.

### Docker Volumes vs Bind Mounts
When you use a bind mount, a file or directory on the host machine is mounted from the host into a container. By contrast, when you use a volume, a new directory is created within Docker's storage directory on the host machine, and Docker manages that directory's contents.
While bind mounts are dependent on the directory structure and OS of the host machine, volumes are completely managed by Docker.


## Instructions

- git clone
- cd inception
- create and fill .env file
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
- setup host name to your preferred domain
```bash
echo "127.0.0.1 <domain_name>" | sudo tee -a /etc/hosts
```
- make

## Resources

### Docker & Containers
- [Docker official documentation](https://docs.docker.com/)
- [Docker Compose reference](https://docs.docker.com/compose/)
- [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [VMs vs docker](https://www.engineyard.com/blog/docker-vs-virtual-machines-explained/)
 
### volumes vs bind mounts
- [Docker official docs - volumes](https://docs.docker.com/engine/storage/volumes/)
- [Docker official docs - bind-mounts](https://docs.docker.com/engine/storage/bind-mounts/)

### NGINX & SSL
- [NGINX beginner's guide](https://nginx.org/en/docs/beginners_guide.html)
- [Configuring HTTPS with NGINX](https://nginx.org/en/docs/http/configuring_https_servers.html)
- [OpenSSL self-signed certificate](https://www.openssl.org/docs/man1.1.1/man1/req.html)
- [some small nginx config](https://serverfault.com/questions/329592/how-does-try-files-work)
 
### WordPress & PHP-FPM
- [WordPress CLI documentation](https://developer.wordpress.org/cli/commands/)
- [PHP-FPM configuration](https://www.php.net/manual/en/install.fpm.configuration.php)
- [mysql Tutorial](https://www.tutorialspoint.com/mysql/index.htm)
 
### MariaDB
- [MariaDB documentation](https://mariadb.com/kb/en/documentation/)

### AI Usage
Claude (Anthropic) was used during this project for:
- Debugging Docker networking and port mapping issues
- Understanding the difference between Docker concepts (volumes, networks, secrets)
- Writing and reviewing the nginx configuration
- Helping structure and write this README and accompanying documentation
