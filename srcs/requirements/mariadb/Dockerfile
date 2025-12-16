FROM debian:bookworm

# Update system
RUN apt update && apt upgrade -y
# Install MariaDB
RUN apt install -y mariadb-server mariadb-client
# Copy config
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# Create log folder
RUN mkdir /var/log/mysql/ && mkdir /var/log/mysql/mariadb-bin/
RUN chown -R mysql:mysql /var/log/mysql
# Create run folder
RUN rm -fr /run/mysqld/mysqld.sock && mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
# Copy setup script
COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

CMD ["/usr/local/bin/script.sh"]
