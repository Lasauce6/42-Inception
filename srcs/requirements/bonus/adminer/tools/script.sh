#!/bin/sh

mkdir -p /var/www/html

wget "https://github.com/vrana/adminer/releases/download/v5.4.2/adminer-5.4.2.php" -O /var/www/html/index.php

chmod 644 /var/www/html/index.php

cd /var/www/html

php -S 0.0.0.0:80
