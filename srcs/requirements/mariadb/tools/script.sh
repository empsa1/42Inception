#!/bin/bash

if [ ! -d "/var/lib/mysql/$BDD_NAME" ]; then
    service mariadb start
    sleep 2s;

    # CREATE USER #
    echo "CREATE USER '$BDD_USER'@'%' IDENTIFIED BY '$BDD_USER_PASSWORD';" | mysql

    # PRIVILGES FOR ROOT AND USER FOR ALL IP ADRESS #
    echo "GRANT ALL PRIVILEGES ON *.* TO '$BDD_USER'@'%' IDENTIFIED BY '$BDD_USER_PASSWORD';" | mysql
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$BDD_ROOT_PASSWORD';" | mysql
    echo "FLUSH PRIVILEGES;" | mysql

    # mysql -uroot -p $PASS -e "" 
    # CREAT WORDPRESS DATABASE #
    echo "CREATE DATABASE $BDD_NAME;" | mysql
    # kill $(cat /var/run/mysqld/mysqld.pid)


    service mariadb stop
fi

mysqld_safe --bind=0.0.0.0