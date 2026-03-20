
# User Docs

## Services used

- **NGINX** - Serving the application, handling https traffic and routes requests to WordPress

- **WordPress** — the actual website, Wordpress is a tool for building and managing websites without having to write code. you can for example write post and manage pages.

- **MariaDB** - the database, storing the WordPress data such as users, comments and posts.

## Setup
before starting the project you must setup required files and config. See instructions part in the README.md

## Start the project
```bash
make
```
Wait for all services to start up. WordPress will automatically install itself on first launch.

## Stop the project
```bash
make down
```
This stops and removes the containers. **Your data is not deleted**
It will be available when you run the project again

## Access the website and the administration panel

Open your browser and go to:
```
https://<your_chosen_domain_name>
```

The site uses a self-signed certificate, so your browser will show a security warning. This is expected — click **Advanced** and then **Proceed** to access the site.

### to access the admin panel

The WordPress administration panel is available at:
```
https://<your_chosen_domain_name>/wp-admin
```
 
Log in with the admin credentials from the `.env` file:
| Field | Value |
|---|---|
| Username | Value of `WP_ADMIN` in `.env` |
| Password | Value of `WP_ADMIN_PASSWORD` in `.env` |

## Locate and manage credentials

All credentials are stored in the `srcs/.env` file at the root of the project.
 
| Credential | Variable in `.env` |
|---|---|
| WordPress admin username | `WP_ADMIN` |
| WordPress admin password | `WP_ADMIN_PASSWORD` |
| WordPress admin email | `WP_ADMIN_EMAIL` |
| WordPress editor username | `WP_USER` |
| WordPress editor password | `WP_USER_PASSWORD` |
| Database name | `DATABASE_NAME` |
| Database user | `MYSQL_USER` |
| Database password | `MYSQL_PASSWORD` |

## Check that services are running correctly

### Container status
```bash
docker ps
```
All services should be there and show status of 'Up'.

### View logs
```bash
make logs        # all services
make logs-wp     # WordPress only
make logs-mbd    # MariaDB only
```

### Quick connection test
```bash
curl -k https://<your_chosen_domain_name>
```
If you see HTML output, NGINX and WordPress are responding correctly.
