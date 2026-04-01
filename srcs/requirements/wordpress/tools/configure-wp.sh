#!/bin/sh

if ! id -u $FTP_USER >/dev/null 2>&1; then
	echo "Création de l'utilisateur FTP : $FTP_USER"
	adduser --disabled-password --gecos "" $FTP_USER
fi

adduser $FTP_USER www-data

chown -R $FTP_USER:www-data /var/www/wordpress
chmod -R 775 /var/www/wordpress
chmod g+s /var/www/wordpress

# Wait for MariaDB
SQL_PASSWORD=$(cat /run/secrets/db_password)
until mysqladmin ping -h mariadb -u"$SQL_USER" -p"$SQL_PASSWORD" --silent --port 3306; do
	echo "Waiting for MariaDB..."
	sleep 2
done

# Create wp config if not exist
if [ ! -f /var/www/wordpress/wp-config.php ]; then
	echo "Creating wp-config.php..."
	wp config create --allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--path=/var/www/wordpress
fi

# Install wp if not installed
if ! wp core is-installed --allow-root --path=/var/www/wordpress 2>/dev/null; then
	echo "Installing wordpress..."
	WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
	wp core install --allow-root \
		--url=$WP_URL \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--skip-email \
		--path=/var/www/wordpress

	# Add 2nd user
	echo "Adding other user..."
	WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
	wp user create --allow-root \
		$WP_USER $WP_USER_EMAIL \
		--user_pass=$WP_USER_PASSWORD \
		--path=/var/www/wordpress

	# Setup wp theme
	wp theme install --path=/var/www/wordpress variations --activate --allow-root

	# Setup redis
	wp config set WP_REDIS_HOST redis --path=/var/www/wordpress --allow-root
	wp config set WP_REDIS_PORT 6379 --path=/var/www/wordpress --allow-root
	wp config set WP_CACHE true --path=/var/www/wordpress --allow-root
	wp plugin install --path=/var/www/wordpress redis-cache --activate --allow-root

	# Update plugins
	wp plugin update --path=/var/www/wordpress --all --allow-root
fi

wp redis enable --path=/var/www/wordpress --allow-root
# Start php-fpm
exec "$@"
