#!/bin/sh

if [ ! -f "srcs/.env" ]; then
	echo "Creating .env file"
	cp srcs/.env.example srcs/.env
fi
