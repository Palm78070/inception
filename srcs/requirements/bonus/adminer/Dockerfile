FROM debian:buster

COPY ./tools/script.sh /

#wget package used for download file from internet
#php used to develop dynamic web app
#php-mysql allow php to communicate to mysql database
RUN apt-get -y update && apt-get -y upgrade \
	&& apt update -y && apt upgrade -y \
	&& apt -y install wget php php-mysql

ENTRYPOINT ["/script.sh"]
