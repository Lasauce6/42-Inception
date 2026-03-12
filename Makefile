# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rbaticle <rbaticle@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/27 14:40:16 by rbaticle          #+#    #+#              #
#    Updated: 2026/03/12 13:19:48 by rbaticle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
DC = docker compose

DC_FILE = srcs/docker-compose.yml
RM = sudo rm -fr

DATA_FOLDER = ~/data/
DATA = $(addprefix $(DATA_FOLDER), wordpress/) $(addprefix $(DATA_FOLDER), mariadb/)

ENV = srcs/.env
SECRETS_FILES = db_password.txt \
				db_root_password.txt \
				wp_admin_password.txt \
				wp_user_password.txt
SECRETS = $(addprefix secrets/, $(SECRETS_FILES))

up: build
	$(DC) -f $(DC_FILE) up -d

debug: build
	$(DC) -f $(DC_FILE) up

$(DATA_FOLDER):
	mkdir $(DATA_FOLDER)

$(DATA):
	mkdir $(DATA)

$(SECRETS):
	chmod +x srcs/tools/init_secrets.sh
	sh srcs/tools/init_secrets.sh

$(ENV):
	chmod +x srcs/tools/init_env.sh
	sh srcs/tools/init_env.sh

build: $(DATA_FOLDER) $(DATA) $(SECRETS) $(ENV)
	$(DC) -f $(DC_FILE) build

stop:
	$(DC) -f $(DC_FILE) stop

ps:
	$(DC) -f $(DC_FILE) ps

clean:
	$(DC) -f $(DC_FILE) down -v

fclean: clean
	$(RM) $(DATA_FOLDER)

re: fclean
	@make up --no-print-directory
