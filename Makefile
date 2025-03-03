NAME = inception

# Data directories
DATA_DIR = /home/gpinilla/data
DB_DATA = $(DATA_DIR)/mysql
WP_DATA = $(DATA_DIR)/wordpress

# Docker Compose
COMPOSE_FILE = srcs/docker-compose.yml

all: prepare build

prepare:
	@echo "Creating data directories..."
	@mkdir -p $(DB_DATA)
	@mkdir -p $(WP_DATA)
	@echo "Setting up /etc/hosts entry..."
	@grep -q "gpinilla.42.fr" /etc/hosts || echo "127.0.0.1 gpinilla.42.fr" | sudo tee -a /etc/hosts

build:
	@echo "Building and starting containers..."
	@cd srcs && docker-compose up -d --build

stop:
	@echo "Stopping containers..."
	@cd srcs && docker-compose stop

down:
	@echo "Removing containers..."
	@cd srcs && docker-compose down

clean: down
	@echo "Removing volumes and data directories..."
	@sudo rm -rf $(DATA_DIR)
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@docker network rm $$(docker network ls -q) 2>/dev/null || true

fclean: clean
	@echo "Removing all Docker images..."
	@docker rmi $$(docker images -qa) 2>/dev/null || true

re: fclean all

.PHONY: all prepare build stop down clean fclean re
