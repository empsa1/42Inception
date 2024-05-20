# SPECIFIES DISTRIBUTION
FROM debian:oldstable

# UPDATE AND INSTALLATION
RUN apt-get update
RUN apt install -y mariadb-server mariadb-common mariadb-client
RUN mkdir /var/run/mysqld/ && chown -R mysql:mysql /var/run/mysqld/
RUN chown -R mysql:mysql /var/lib/mysql
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld
#RUN apt install -y mysql-client 

# COPY THE CONF FOR THE BIND AND THE SQL SCRIPT FOR THE PRIVILEGE
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# COPY THE SCRIPT IN THE IMAGES AND MODIFY THE EXECUTION RIGHTS OF IT
COPY ./tools/script.sh /
RUN  chmod +x /script.sh

EXPOSE 3306

CMD [ "/script.sh" ]