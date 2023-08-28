FROM debian:buster

RUN apt-get update -y && apt-get install mariadb-server -y \
	&& apt-get install -y procps

#RUN mkdir -p /var/run/mysqld \
#	&& chown mysql:mysql /var/run/mysqld \
#	&& chmod -R 755 /var/run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /

EXPOSE 3306

ENTRYPOINT ["/script.sh"]
