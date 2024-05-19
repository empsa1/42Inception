#!/bin/sh

mysql_install_db

/etc/init.d/mariadb start

#Check if the database exists

if [ -d "/var/lib/mysql/$db1_name" ]
then 

	echo "Database already exists"
else

# Set root option so that connexion without root password is not possible

mysql_secure_installation << _EOF_

Y
root4life
root4life
Y
n
Y
Y
_EOF_

#Add a root user on 127.0.0.1 to allow remote connexion 
#Flush privileges allow to your sql tables to be updated automatically when you modify it
#mysql -uroot launch mysql command line client
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$WP_ADMIN_PWD'; FLUSH PRIVILEGES;" | mysql -uroot

#Create database and user in the database for wordpress

echo "CREATE DATABASE IF NOT EXISTS $db1_name; GRANT ALL ON $db1_name.* TO '$WP_ADMIN_USR'@'%' IDENTIFIED BY '$WP_ADMIN_PWD'; FLUSH PRIVILEGES;" | mysql -u root

#Import database in the mysql command line
mysql -uroot -p$WP_ADMIN_PWD $db1_name < /usr/local/bin/wordpress.sql

fi

/etc/init.d/mariadb stop

exec "$@"