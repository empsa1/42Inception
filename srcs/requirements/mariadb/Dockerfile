FROM debian:11

RUN apt-get update && apt-get install -y mariadb-server

COPY conf/my.cnf /etc/mysql/my.cnf

EXPOSE 3306

CMD ["mysqld"]
