#!/bin/bash

#use wget to download adminer from internet and place it in /var/www/html
wget https://www.adminer.org/latest-mysql.php -O /var/www/html/adminer.php

#grant ownership to user:group www-data which usually used by web server
chown -R www-data:www-data /var/www/html/adminer.php

chmod 755 /var/www/html/adminer.php

cd /var/www/html

#ensure that adminer.php will be used instead of index.php
rm -rf index.html

#start php server -S to tell php to start built-in server
php -S 0.0.0.0:80 -t /var/www/html
