# 42 - Inception

*This project has been created as part of the 42 curriculum by rbaticle*

## Description

Inception is a project to learn how to use Docker, create Dockerfiles, use docker network and much more...
The goal of the project is to create three diferents dockers containers:
 - One for the mariadb database
 - One for the nginx server
 - The last one for the wordpress site with PHP

Each containers must communicate with specific ports via the docker network, only the nginx container must be accesible by https (port 443)

### Virtual Machines vs Docker

Like Virtual Machines, Docker allow to create a separate specific environement to run programs on an other os than the host machine.
The main difference is that a Virtual Machine will virtualize an entire machine with the CPU, memory, network interface... and docker will only let you choose the bare minimum and customize as you want the process installed and used

Docker is mainly used to run an app or a specific service using less resources than a VM in a docker container, the resources are used on demand by the container unlike the VM that allocates, memory and CPU and releases it only after the VM is closed

### Secrets vs Environement Variables

Docker secrets are sensitive data such as passwords, ssh keys or other sensitive data wich is encrypted in the Dockerfile.
Theses secrets can only be used by the docker containers who have access to it
It allows to transfert and share Dockerfiles without exposing raw data to public and risk a security issue

Environement variables on the other hand are plain text stored typically on a .env file to get paths or other data that can be publicly available
As the .env file is storing data in plain text, the Environement variables should not be sensitive data
Environement variables are also use in Linux to store for example the username ($USER), or the path of executables ($PATH)

### Docker network vs Host network

Docker network is a separated network from the Host network
By default when starting a docker container, a bridge network is created to link the host network with the docker network
This bridge can be disabled in the Dockerfile or docker-compose file and other networks can be created to link containers with each others
In thoses networks ports can be openned to communicate with dockers containers or to the host network via the bridge network

The host network is completly separated from docker network allowing to isolate the trafic and protect the containers from security breachs

### Docker volumes vs Bind mounts

Bind mounts are used in docker containers to use a folder wich is attached to the container
All the files are now accesibles on the docker container
By contrast, a docker volume is a folder created by the docker container on the host machine to store and manage data from the docker container


## Instructions

Here is how to use and compile this project:

**Install prerequisites (for Ubuntu [*Others OS*](https://docs.docker.com/compose/install/linux/#install-using-the-repository)):**

```sh
# Uninstall older versions
sudo apt remove $(dpkg --get-selections docker.io docker-compose \
docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)

# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

# Install the docker compose plugin
sudo apt-get update && sudo apt-get install docker-compose-plugin

# Verify the docker compose installation
docker compose version
```

**Create the .env file:**

```sh
cp srcs/.env.example srcs/.env
```
*You can modify the .env file with your needs (use ```nano srcs/.env``` or any text editor of your choice)*

**Run the project:**

```sh
# Build and lauch the containers detached
make

# Build and launch the containers not detached
make debug

# Only build the containers
make build

# Stop the containers
make stop

# List the containers
make ps

# Delete and clean the containers
make clean

# Delete and clean the containers and the persistent data
make fclean

# Fresh start
make re
```

## Resources

Links and references:
- [Writing a Dockerfile - Docker Docs](https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/)
- [Docker Compose - Docker Docs](https://docs.docker.com/compose/)
- [Docker vs VM - AWS](https://aws.amazon.com/compare/the-difference-between-docker-vm/)
- [Manage sensitive data with docker secrets - Docker Docs](https://docs.docker.com/engine/swarm/secrets/)
- [Networking overview - Docker Docs](https://docs.docker.com/engine/network/)
- [Volumes - Docker Docs](https://docs.docker.com/engine/storage/volumes/)
- [Bind Mounts - Docker Docs](https://docs.docker.com/engine/storage/bind-mounts/)

Use of AI in this project:
- Used to refractor the readmes and to generate cleans commits messages
- Used to explain concepts about Docker
