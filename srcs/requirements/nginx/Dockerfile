FROM debian:11

RUN apt-get update && apt-get install -y nginx openssl

COPY ./tools/script.sh /

CMD ["./script.sh"]
