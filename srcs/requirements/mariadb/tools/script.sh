#!/bin/sh
set -e

# Start MariaDB in background
mysqld_safe &

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
	sleep 2
done

# Init database and user
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};

CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';

FLUSH PRIVILEGES;
EOF

# Stop background mysqld_safe
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Start MariaDB in foreground (PID 1)
exec mysqld
