FROM debian:oldstable

RUN apt update -y 

RUN     apt-get update && \
		apt-get install -y  \
		php php-mysql php-fpm php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip mariadb-server mariadb-client curl

RUN mkdir -p /var/run/php

COPY ./tools/script.sh /
COPY	./conf/www.conf /etc/php/7.4/fpm/pool.debian
COPY ./conf/wp-config.php /var/www/html/

RUN 	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp

RUN chmod +x /script.sh

EXPOSE 9000

CMD [ "./script.sh" ]