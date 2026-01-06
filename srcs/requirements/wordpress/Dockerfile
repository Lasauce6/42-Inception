FROM debian:bookworm

# Update system
RUN apt update && apt upgrade -y
# Install dependecies
RUN apt-get install -y wget \
 curl \
 php7.3 \
 php-fpm \
 php-mysql \
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

# Configure php-fpm
RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf
RUN sed -i 's/;listen.owner = www-data/listen.owner = www-data/' /etc/php/8.2/fpm/pool.d/www.conf
RUN sed -i 's/;listen.group = www-data/listen.group = www-data/' /etc/php/8.2/fpm/pool.d/www.conf
RUN mkdir -p /run/php

# Add script
COPY tools/configure-wp.sh /usr/local/bin/configure-wp.sh
RUN chmod +x /usr/local/bin/configure-wp.sh

ENTRYPOINT ["/usr/local/bin/configure-wp.sh"]

CMD ["/usr/sbin/php-fpm8.2", "-F"]

