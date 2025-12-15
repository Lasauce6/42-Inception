# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rbaticle <rbaticle@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/27 14:40:16 by rbaticle          #+#    #+#              #
#    Updated: 2025/12/15 15:28:07 by rbaticle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
DC = docker compose

DC_FILE = srcs/docker-compose.yml

up: build
	$(DC) -f $(DC_FILE) up -d

debug: build
	$(DC) -f $(DC_FILE) up

build:
	$(DC) -f $(DC_FILE) build

stop:
	$(DC) -f $(DC_FILE) stop

ps:
	$(DC) -f $(DC_FILE) ps

clean:
	$(DC) -f $(DC_FILE) down -v

