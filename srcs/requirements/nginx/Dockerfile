FROM debian:oldstable

RUN apt-get update && apt-get install -y nginx openssl

COPY ./tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["/usr/local/bin/script.sh"]
