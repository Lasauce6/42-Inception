from debian:bookworm

# Update system
RUN apt update && apt upgrade -y
# Install dependecies
RUN apt-get install -y wget \
php7.3\
php-fpm\
php-mysql\
mariadb-client
# Download and install wordpress
RUN wget https://wordpress.org/wordpress-6.9.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.9.tar.gz && rm wordpress-6.9.tar.gz
# Set permissions
RUN chmod -R 755 /var/www/wordpress

