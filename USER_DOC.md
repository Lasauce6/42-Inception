# User Documentation

This document provides a guide for the end users and administrators on how to use and manage the Inception stack

## Services Provided

This project deploys a fully functional WordPress website with the following services:
- **WordPress**: A content management system (CMS) powered by PHP-FPM
- **MariaDB**: A relational database to store the website data
- **NGINX**: A web server that serves the site over HTTPS (SSL/TLS)

Bonuses containers:
- **Redis**: A cache server to have a fast WordPress site
- **FTP**: A FTP server to access the WordPress site files
- **website**: A simple html memory game website
- **Adminer**: A database management service to manage the MariaDB database
- **Uptime Kuma**: A simple monitoring tool to monitor the diferent services

## Starting and Stoping the project

All interactions are managed via the Makefile

### Start the project

To build and launch the containers in the background (detached mode):
```sh
make
```

### Stop the project

To stop the running containers without deleting them:
```sh
make stop
```

### Restart the project

To stop, clean, and restart the project from scratch:
```sh
make re
```

## Accessing the Website

Once the project is running, you can access the services via your web browser

- **Website**: Access the WordPress site via HTTPS on port 443
    - URL: ```https://<DOMAIN_NAME_in_.env>```
- **Administration Pannel**: Access the WordPress admin dashboard
    - URL: ```https://<DOMAIN_NAME_in_.env>/wp-admin```

> **Note**: Since the project uses a self-signed certificate by default, your browser might warn you about the connection security. You can proceed by accepting the risk

## Managing Credentials

Credentials are stored securely using Docker Secrets

- **Location**: The password are defined in plain text files inside the ```secrets/``` directory at the root of the project
- **Files**:
    - ```secrets/db_password.txt```: Password for the database user
    - ```secrets/db_admin_password.txt```: Password for the database root user
    - ```secrets/wp_admin_password.txt```: Password for the WordPress admin user
    - ```secrets/wp_user_password.txt```: Password for the WordPress standard user
    - ```secrets/ftp_password.txt```: Password for the FTP client


To change a password:

1. Stop the project (```make stop```)
2. Edit the corresponding file in the ```secrets/``` directory
3. Rebuild and restart the project (```make re```)

## Checking Service Status

To verify that all containers are running correctly:
```sh
make ps
```

You should see eight containers running:
- ```mariadb```
- ```wordpress```
- ```nginx```
- ```redis```
- ```ftp```
- ```website```
- ```adminer```
- ```uptime-kuma```

If a container has a status of ```Exited```, check the logs using ```docker logs <container_name>```


