from debian:bookworm

# Update system
RUN apt update && apt upgrade -y
# Install dependecies
RUN apt-get install -y wget \
curl \
php7.3\
php-fpm\
php-mysql\
mariadb-client
# Download and install wordpress
RUN wget https://wordpress.org/wordpress-6.9.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.9.tar.gz && rm wordpress-6.9.tar.gz
# Set permissions
RUN chmod -R 755 /var/www/wordpress
# Install wordpress-cli to configure wp
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
COPY conf/configure-wp.sh /usr/local/bin/configure-wp.sh
RUN chmod +x /usr/local/bin/configure-wp.sh

ENTRYPOINT ["/usr/local/bin/configure-wp.sh"]

CMD ["/usr/sbin/php-fpm7.3", "-F"]

