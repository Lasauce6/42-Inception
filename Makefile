# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rbaticle <rbaticle@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/27 14:40:16 by rbaticle          #+#    #+#              #
#    Updated: 2026/02/25 14:23:42 by rbaticle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
DC = docker compose

DC_FILE = srcs/docker-compose.yml
RM = sudo rm -fr

DATA_FOLDER = ~/data/
DATA = $(addprefix $(DATA_FOLDER) wordpress/) $(addprefix $(DATA_FOLDER) mariadb/)

up: build
	$(DC) -f $(DC_FILE) up -d

debug: build
	$(DC) -f $(DC_FILE) up

$(DATA_FOLDER):
	mkdir $(DATA_FOLDER)

$(DATA):
	mkdir $(DATA)

build: $(DATA_FOLDER) $(DATA)
	$(DC) -f $(DC_FILE) build

stop:
	$(DC) -f $(DC_FILE) stop

ps:
	$(DC) -f $(DC_FILE) ps

clean:
	$(DC) -f $(DC_FILE) down -v

fclean: clean
	$(RM) $(DATA_FOLDER)

re: fclean $(DATA)
	$(DC) -f $(DC_FILE) build
	$(DC) -f $(DC_FILE) up -d
