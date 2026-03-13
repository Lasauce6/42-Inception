#!/bin/sh
set -e

# Verify if MariaDB is already initialised
if ! [ -f "/var/lib/mysql/done" ]; then
	echo "Première initialisation de MariaDB..."

	# Install the database
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	# Start MariaDB in background
	mysqld_safe &

	# Wait for MariaDB to be ready
	until mariadb-admin ping --silent; do
		echo "En attente de MariaDB..."
		sleep 2
	done

	echo "Création de la base de données et de l'utilisateur..."

	SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
	SQL_PASSWORD=$(cat /run/secrets/db_password)

	# Init database and user
	mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

	echo "Base de données et utilisateur créés avec succès."

	# Stop background mariadb_safe
	mariadb-admin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

	touch /var/lib/mysql/done

	echo "Initialisation terminée."
fi

# Start MariaDB in foreground (PID 1)
exec mariadbd
