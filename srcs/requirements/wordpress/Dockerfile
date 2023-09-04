FROM debian:buster

#curl package: command-line tool to transfer data using various network protocol HTTP, HTTPS, FTP
RUN apt-get -y update && apt-get -y upgrade \
	&& apt update -y && apt upgrade -y \
	&& apt install php-fpm php-mysql -y && apt install curl -y

COPY ./tools/script.sh /
COPY ./conf/wp-config.php /

#RUN chomd 775 script.sh

#EXPOSE 9000

ENTRYPOINT ["/script.sh"]
