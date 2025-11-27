from debian:bookworm

# Update system
RUN apt update && apt upgrade -y
# Install nginx
RUN apt install nginx -y
# Setup TLS
RUN mkdir -p /etc/nginx/ssl/
RUN apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=rbaticle"
# Change nginx config
RUN mkdir -p /var/run/nginx/
COPY conf/nginx.conf /etc/nginx/nginx.conf
# Setup permisisons
RUN chmod 755 /var/www/wordpress
RUN chown -R www.data:www.data /var/www/wordpress
# Run nginx
CMD [ "nginx", "-g", "daemon off;" ]
