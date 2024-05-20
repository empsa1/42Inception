#!/bin/bash

# Load environment variables from .env file
source .env

# Create directory for WordPress installation
mkdir -p /var/www/html

# Navigate to the WordPress directory
cd /var/www/html

# Remove existing files
rm -rf *

# Download and install WP CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp

# Download WordPress core files
wp core download --allow-root

# Create wp-config.php from sample configuration
wp config create --dbname="$BDD_NAME" --dbuser="$BDD_USER" --dbpass="$BDD_USER_PASSWORD" --dbhost="$BDD_HOST" --skip-check --allow-root

# Install WordPress
wp core install --url="$DOMAIN_NAME/" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root

# Create a new user
wp user create "$WP_USER" "$WP_USER_EMAIL" --role="$WP_USER_ROLE" --user_pass="$WP_USER_PASSWORD" --allow-root

# Install Astra theme and activate it
wp theme install astra --activate --allow-root

# Update all plugins
wp plugin update --all --allow-root

# Replace the PHP-FPM socket with port 9000 in the FPM pool configuration
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

# Create directory for PHP-FPM socket
mkdir -p /run/php

# Start PHP-FPM
/usr/sbin/php-fpm7.3 -F
