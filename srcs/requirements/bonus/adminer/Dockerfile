FROM debian:bookworm

RUN apt update -y

COPY tools/script.sh /
RUN chmod +x /script.sh

RUN apt install -y wget php8.2 php-mysql

CMD ["/script.sh"]
