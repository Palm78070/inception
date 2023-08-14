# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rthammat <rthammat@42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/14 18:25:15 by rthammat          #+#    #+#              #
#    Updated: 2023/08/14 23:33:53 by rthammat         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

up:
	docker compose -f up srcs/docker-compose.yml

down:
	docker compose -f down srcs/docker-compose.yml

start:
	docker compose -f start srcs/docker-compose.yml

stop:
	docker compose -f stop srcs/docker-compose.yml

status:
	docker ps

.PHONY: up down start stop status
