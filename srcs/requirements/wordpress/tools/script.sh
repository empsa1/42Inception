#!/bin/bash

sed -ie "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/" /etc/php/7.4/fpm/pool.d/www.conf


echo "---------------------------------"
wall " Printing the environment variables"
echo "MYSQL_DATABASE: $BDD_NAME"
echo "MYSQL_USER: $BDD_USER"
echo "MYSQL_PASSWORD: $BDD_USER_PASSWORD"
echo "DB_HOST: $DB_HOST"
echo "WP_URL: $WP_URL"
echo "WP_TITLE: $WP_TITLE"
echo "WP_ADMIN: $WP_ADMIN"
echo "WP_ADMIN_PASSWORD: $WP_ADMIN_PASSWORD"
echo "WP_USER: $WP_USER"
echo "WP_USER_PASSWORD: $WP_USER_PASSWORD"
echo "---------------------------------"


if [ ! -f /var/www/html/wp-config.php ]; then
	
	cd /var/www/html/
	mv 	/wp-config.php /var/www/html/

	sed -i "s/__MYSQL_DATABASE__/'$BDD_NAME'/g" /var/www/html/wp-config.php
	sed -i "s/__MYSQL_USER__/'$BDD_USER'/g" /var/www/html/wp-config.php
	sed -i "s/__MYSQL_PASSWORD__/'$BDD_ROOT_PASSWORD'/g" /var/www/html/wp-config.php
	sed -i "s/__DB_HOST__/'$DB_HOST'/g" /var/www/html/wp-config.php
	
	wp core download --allow-root
	until mysqladmin -hmariadb -u${MYSQL_USER} -p${MYSQL_PASSWORD} ping; do
       sleep 2
    done
	wp config create --dbname=${BDD_NAME} --dbuser=${BDD_USER} --dbpass=${BDD_USER_PASSWORD} --dbhost=mariadb:3306 --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	wp core install --url=${WP_URL} --title="${WP_TITLE}" --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email="$WP_ADMIN@student.42.fr" --allow-root
	wp user create ${WP_USER} "$WP_USER"@user.com --role=author --user_pass=${WP_USER_PASSWORD} --allow-root

	chown -R www-data:www-data /var/www/html/wp-content
fi


exec /usr/sbin/php-fpm7.4 -F