#!/bin/bash

# systemctl start mysql

# echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" > db.sql
# echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db.sql
# echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' ;" >> db.sql
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY $MYSQL_ROOT_PASSWORD ;" >> db.sql
# echo "FLUSH PRIVILEGES;" >> db.sql

# mysql < db.sql

# systemctl restart mysql

#####test#####
systemctl start mysql

echo "CREATE DATABASE IF NOT EXISTS WordpressDB ;" > db.sql
echo "CREATE USER IF NOT EXISTS 'Palm'@'%' IDENTIFIED BY '1234' ;" >> db.sql
echo "GRANT ALL PRIVILEGES ON WordpressDB.* TO 'Palm'@'%' ;" >> db.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY P@lm78070 ;" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql

mysql < db.sql

systemctl restart mysql
