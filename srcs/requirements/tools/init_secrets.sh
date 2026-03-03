#!/bin/sh

mkdir -p secrets

generate_secret() {
	local file=$1
	local default_value=$2

	if [ ! -f "$file" ]; then
		echo "Creating secret : $file"
		echo "$default_value" > "$file"
	fi
}

generate_secret "secrets/db_password.txt" "db-pass"
generate_secret "secrets/db_root_password.txt" "db-root-pass"
generate_secret "secrets/wp_admin_password.txt" "wp-admin-pass"
generate_secret "secrets/wp_user_password.txt" "wp-user-pass"
