#!/bin/bash

#service mysql start
#
#echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" > db.sql
#echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" >> db.sql
#echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db.sql
#echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' ;" >> db.sql
#echo "FLUSH PRIVILEGES;" >> db.sql
#
#mysql -u root < db.sql
#service mysql restart

#mkdir -p /var/run/mysqld
#chown mysql:mysql /var/run/mysqld/
#chmod -R 755 /var/run/mysqld/
#
#/etc/init.d/mysql start
#
#sleep 5
## Check if the database already exists -> if no database throw message error(fd 2) to /dev/null
#if [ -d "/var/lib/mysql/$MYSQL_DB_NAME" ]; then
#	echo "Database already exists"
#else
#	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" > db.sql
#	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" >> db.sql
#	echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db.sql
#	echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' ;" >> db.sql
#	echo "FLUSH PRIVILEGES;" >> db.sql
#
#	mysql -uroot -p$MYSQL_ROOT_PASSWORD < db.sql
#
#	#Stop mysql server
#	mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown
#
#	#Wait for mysql server to stop
#	while ps aux | grep -v grep | grep mysqld; do
#		sleep 1
#	done
#
#	# --user=mysql -> run mysqld with user mysql which have limited system privileges for security reason
#	# --console -> send mysql error log/other message to terminal instead of log file
#	# --skip-name-resolve -> prevent mysql server from DNS lookups when clients connect(long delay and slow performance)
#	# --skip-networking=0 -> 0 enables network connections to the MySQL server(if 1 you connect only through unix socket)
#	mysqld_safe --user=mysql --console --skip-name-resolve --skip-networking=0
#fi

######################################################################
mkdir -p /var/run/mysqld
chown mysql:mysql /var/run/mysqld/
chmod -R 755 /var/run/mysqld/

/etc/init.d/mysql start

sleep 5
# Check if the database already exists -> if no database throw message error(fd 2) to /dev/null
#if mysql -uroot -pP@lm78070 -e "USE WordpressDB;" 2>/dev/null; then
if [ -d "/var/lib/mysql/WordpressDB" ]; then
	echo "Database already exists"
else
	echo "CREATE DATABASE IF NOT EXISTS WordpressDB ;" > db.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'P@lm78070' ;" >> db.sql
	echo "CREATE USER IF NOT EXISTS 'Palm'@'%' IDENTIFIED BY '1234' ;" >> db.sql
	echo "GRANT ALL PRIVILEGES ON WordpressDB.* TO 'Palm'@'%' ;" >> db.sql
	echo "FLUSH PRIVILEGES;" >> db.sql

	mysql -uroot -pP@lm78070 < db.sql

	#Stop mysql server
	mysqladmin -uroot -pP@lm78070 shutdown

	#Wait for mysql server to stop
	while ps aux | grep -v grep | grep mysqld; do
		sleep 1
	done

	# --user=mysql -> run mysqld with user mysql which have limited system privileges for security reason
	# --console -> send mysql error log/other message to terminal instead of log file
	# --skip-name-resolve -> prevent mysql server from DNS lookups when clients connect(long delay and slow performance)
	# --skip-networking=0 -> 0 enables network connections to the MySQL server(if 1 you connect only through unix socket)
	mysqld_safe --user=mysql --console --skip-name-resolve --skip-networking=0
fi
