FROM debian:bookworm

# Update system
RUN apt update && apt upgrade -y
# Install MariaDB
RUN apt-get install -y mariadb-server
# Copy config
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# Copy setup script
RUN ss -ln | grep mysqld
COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

CMD ["/usr/local/bin/script.sh"]
