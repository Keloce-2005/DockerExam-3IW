#!/bin/bash

set -e
cd /var/www/html

git config --global --add safe.directory /var/www/html || true

chown -R www-data:www-data /var/www/html

composer install --no-interaction --prefer-dist --optimize-autoloader
npm install
npm run build

php artisan key:generate
php artisan migrate:fresh --seed

exec php-fpm
