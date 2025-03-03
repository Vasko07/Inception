# Inception

This project sets up a small infrastructure composed of different services using Docker containers following specific rules.

## Overview

The infrastructure consists of:

- NGINX container with TLSv1.3
- WordPress + php-fpm container
- MariaDB container
- Docker volumes for WordPress database and files
- Custom Docker network

## Requirements

- Docker and Docker Compose
- Make
- sudo privileges (for /etc/hosts modification)

## Installation

1. Clone the repository
2. Run the setup:

```bash
make
```

This will:
- Create necessary data directories
- Add the domain to /etc/hosts
- Build and start the Docker containers

## Usage

Access the WordPress site at https://gpinilla.42.fr

## Available Commands

- `make`: Set up the environment and start all services
- `make prepare`: Create data directories and set up /etc/hosts
- `make build`: Build and start the Docker containers
- `make stop`: Stop the containers
- `make down`: Remove the containers
- `make clean`: Remove containers, volumes, and data directories
- `make fclean`: Perform clean and remove all Docker images
- `make re`: Rebuild everything from scratch

## Services

- **NGINX**: Serves as the entry point, handling HTTPS connections on port 443
- **WordPress**: Runs the WordPress application with PHP-FPM
- **MariaDB**: Database server for WordPress

## File Structure

```
.
├── Makefile
└── srcs
    ├── docker-compose.yml
    ├── .env
    └── requirements
        ├── mariadb
        │   ├── conf
        │   ├── Dockerfile
        │   └── tools
        ├── nginx
        │   ├── conf
        │   ├── Dockerfile
        │   └── tools
        └── wordpress
            ├── conf
            ├── Dockerfile
            └── tools
```
