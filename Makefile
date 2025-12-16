# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rbaticle <rbaticle@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/27 14:40:16 by rbaticle          #+#    #+#              #
#    Updated: 2025/12/16 12:46:33 by rbaticle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
DC = docker compose

DC_FILE = srcs/docker-compose.yml

DATA = ~/data/ ~/data/wordpress/ ~/data/mariadb/

up: $(DATA)
	$(DC) -f $(DC_FILE) up -d

debug: $(DATA)
	$(DC) -f $(DC_FILE) up

$(DATA):
	mkdir $(DATA)

build: $(DATA)
	$(DC) -f $(DC_FILE) build

stop:
	$(DC) -f $(DC_FILE) stop

ps:
	$(DC) -f $(DC_FILE) ps

clean:
	$(DC) -f $(DC_FILE) down -v

fclean: clean
	sudo rm -fr ~/data/mariadb/*
	sudo rm -fr ~/data/wordpress/*

re: fclean $(DATA)
	$(DC) -f $(DC_FILE) up -d
