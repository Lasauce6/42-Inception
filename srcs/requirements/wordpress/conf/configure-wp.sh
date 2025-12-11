#!/bin/sh

sleep 10

wp config create --allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 \
	--path=/var/www/wordpress

if wp core is-installed 2>/dev/null; then
	wp core install --url=$WP_URL \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--skip-email
	wp user create $WP_USER $WP_USER_EMAIL \
		--user_pass=$WP_USER_PASSWORD \
fi
