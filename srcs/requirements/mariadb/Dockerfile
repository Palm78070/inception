FROM debian:buster

RUN apt-get update -y && apt-get install mariadb-server -y \
	&& apt-get install mariadb-client -y \
	&& apt-get install -y procps

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod -R 755 /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /

EXPOSE 3306

RUN /script.sh

CMD ["mysqld_safe", "--user=mysql", "--console", "--skip-name-resolve", "--skip-networking=0"]
	# --user=mysql -> run mysqld with user mysql which have limited system privileges for security reason
	# --console -> send mysql error log/other message to terminal instead of log file
	# --skip-name-resolve -> prevent mysql server from DNS lookups when clients connect(long delay and slow performance)
	# --skip-networking=0 -> 0 enables network connections to the MySQL server(if 1 you connect only through unix socket)
