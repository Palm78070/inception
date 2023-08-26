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
#tail -f /dev/null

#service mysql start
#chown mysql:mysql /var/run/mysqld/
#chmod -R 755 /var/run/mysqld/

/etc/init.d/mysql start

sleep 5

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

mysqld --user=mysql --console --skip-name-resolve --skip-networking=0
