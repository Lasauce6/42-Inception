#!/bin/sh
set -e

# Modifier le bind-address pour accepter les connexions externes
sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Verify if MariaDB is already initialised
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Première initialisation de MariaDB..."

	# Install the database
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	# Start MariaDB in background
	mysqld_safe &

	# Wait for MariaDB to be ready
	until mysqladmin ping --silent; do
		echo "En attente de MariaDB..."
		sleep 2
	done

	echo "Création de la base de données et de l'utilisateur..."

	# Init database and user
	mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

	echo "Base de données et utilisateur créés avec succès."

	# Stop background mysqld_safe
	mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

	echo "Initialisation terminée."
fi

# Start MariaDB in foreground (PID 1)
exec mysqld
