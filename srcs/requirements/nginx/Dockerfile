FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl

COPY ./tools/script.sh /

CMD ["./script.sh"]
