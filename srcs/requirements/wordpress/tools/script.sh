#!/bin/bash

if [ ! -d "/var/www/html/wp-config.php" ]; then
	#Create dir to use in nginx container + setup wordpress conf
	if [ ! -d "/var/www" ]; then
		mkdir /var/www/
		mkdir /var/www/html
	fi

	cd /var/www/html

	#Remove wordpress file from previous volume to reinstall
	rm -rf *

	#Command for install + using WP-CLI tool => WP-CLI(Wordpress command line interface)

	#download WP-CLI PHAR(PHP Archive) -0 tells file to save the same name as server
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

	#Make WP-CLI PHAR file executable
	chmod +x wp-cli.phar

	#Moves WP-CLI PHAR file to /usr/local/bin which is in the system PATH
	#and renames to wp => allows you to run wp command from any dir
	mv wp-cli.phar /usr/local/bin/wp

	#Download latest version of Wordpress to current dir --allow-root allows to run as root user
	wp core download --allow-root

#	if [ ! -d "/var/www/html/wp-config.php" ]; then
		mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
	#	mv /wp-config.php /var/www/html/wp-config.php
#	fi

	#Change line in wp-config.php file to connect with database
	#sed -i -r => -i edit file in place => any changes are saved directly to file
	#-r =>  use extended regular expressions
	#s/old_pattern/new_pattern/1 => /1 only the first occurrence of the old pattern should be replaced if replace all occurrences ue /g
	#sed -i -r "s/db_name/$MYSQL_DB_NAME/1" wp-config.php
	#sed -i -r "s/db_user/$MYSQL_USER/1"  wp-config.php
	#sed -i -r "s/db_pw/$MYSQL_PASSWORD/1"    wp-config.php
	#sed -i -r "s/localhost/mariadb/1"    wp-config.php
	sed -i -r "s/database_name_here/$MYSQL_DB_NAME/1" wp-config.php
	sed -i -r "s/username_here/$MYSQL_USER/1"  wp-config.php
	sed -i -r "s/password_here/$MYSQL_PASSWORD/1"    wp-config.php
	sed -i -r "s/localhost/mariadb/1"    wp-config.php
	sed -i -r "s/'WP_DEBUG', false/'WP_DEBUG', true/1"    wp-config.php

	#wp --allow-root config create --dbname=$MYSQL_DB_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --locale=en_DB --dbhost=mariadb;

	#install WordPress + set up basic conf
	#--url specifies url of the site
	#--title sets title of the site
	#--admin_user, --admin_password, --admin_email set user/password/email for site's admin
	#--skip-email prevents WP-CLI from sending email to admin with login detail
	wp --allow-root core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PW --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

	wp user create $WP_USR $WP_USR_EMAIL --role=author --user_pass=$WP_USR_PW --allow-root

	#Install Astra theme + activates it for the sites --activate tells WP-CLI to make astra the activate theme for sites
	wp theme install astra --activate --allow-root

	wp plugin update --all --allow-root

	#Use sed to modify www.conf in /etc/php/7.3/fpm/pool.d dir
	#The s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g substitutes value 9000 for /run/php/php7.3-fpm.sock for entire file
	#This change "socket" that PHP-FPM listens on from Unix domain socket to a TCP port
	sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

	#Creates /run/php dir used by PHP-FPM to store Unix domain sockets
	if [ ! -d "/run/php" ]; then
		mkdir /run/php
	fi

	#Starts PHP-FPM service in the foreground, -F tells PHP-FPM to run in foreground rather than daemon in background
fi
/usr/sbin/php-fpm7.3 -F
