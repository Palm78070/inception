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

build:
	cd srcs && docker-compose build && cd ../

# up => create + start containers defined in compose file
up:
	cd srcs && docker-compose up -d && cd ../

down:
	cd srcs && docker-compose down && cd ../

# start => start containers that currently stop
start:
	cd srcs && docker-compose start && cd ../

stop:
	cd srcs && docker-compose stop && cd ../

status:
	docker ps

logs:
	cd srcs && docker-compose logs && cd ../

rm_images:
	docker images -q | xargs -r docker rmi -f

.PHONY: build up down start stop status rm_images
