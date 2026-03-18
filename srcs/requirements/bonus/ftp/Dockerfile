FROM debian:bookworm

RUN apt update -y

# Install vsftpd
RUN apt install -y vsftpd

COPY ./tools/script.sh /
RUN chmod +x /script.sh

CMD ["script.sh"]
