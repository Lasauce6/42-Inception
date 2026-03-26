FROM debian:bookworm

RUN apt update -y

# Install vsftpd
RUN apt install -y vsftpd
RUN useradd --system ftp

COPY ./tools/script.sh /
RUN chmod +x /script.sh
RUN echo $FTP_USER > /etc/vsftpd.userlist

CMD ["script.sh"]
