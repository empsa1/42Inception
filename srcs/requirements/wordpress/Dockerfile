FROM debian:11

RUN apt-get update && apt-get install -y php php-fpm php-mysql

COPY conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

EXPOSE 9000

CMD ["php-fpm"]
