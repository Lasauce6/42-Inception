#!/bin/sh

cd /app

if [ ! -f /app/data/kuma.db ]; then
	echo "First launch : Init the database..."

	mkdir -p /app/data

	cp /app/init_db/kuma.db /app/data/kuma.db
else
	echo "Database detected."
fi

npm run setup

echo "Wait 10 secs before starting to wait for other containers ..."
sleep 10
echo "Done."

echo "Starting Uptime Kuma ..."
exec node server/server.js
