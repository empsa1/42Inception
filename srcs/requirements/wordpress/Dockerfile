FROM debian:buster

RUN apt update -y 
RUN apt install php-fpm php-mysql curl -y

COPY ./tools/script.sh /
COPY ./tools/wp-config.php /var/www/html/

CMD [ "./script.sh" ]

