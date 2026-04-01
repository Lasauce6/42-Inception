FROM debian:bookworm

RUN apt update -y

# Install vsftpd
RUN apt install -y vsftpd

COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

CMD ["/usr/local/bin/script.sh"]
