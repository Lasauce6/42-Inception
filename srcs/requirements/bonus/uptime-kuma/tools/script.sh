#!/bin/sh

cd /app

if [ ! -f /app/data/kuma.db ]; then
	echo "First launch : Init the database..."

	mkdir -p /app/data

	cp /app/init_db/kuma.db /app/data/kuma.db
else
	echo "Database detected."
fi

. "/root/.nvm/nvm.sh" && nvm use 24
npm run setup

echo "Starting Uptime Kuma ..."
exec node server/server.js
