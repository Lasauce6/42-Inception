from debian:bookworm

# Update system
RUN apt update && apt upgrade -y
# Install MariaDB
RUN apt-get install mariadb-server -y
# Copy config
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# Copy setup script
COPY tools/create_db.sh /usr/local/bin/create_db.sh
RUN chmod +x /usr/local/bin/create_db.sh

ENTRYPOINT ["/usr/local/bin/create_db.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]
