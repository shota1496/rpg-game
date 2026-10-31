#!/bin/bash

# Renderから指定されたPORTをNginxの設定に反映
sed -i "s/listen 10000;/listen ${PORT:-10000};/g" /etc/nginx/sites-available/default

# データベースのマイグレーションを自動実行
php artisan migrate --force

# Laravelのキャッシュ最適化
php artisan config:cache
php artisan route:cache
php artisan view:cache

# PHP-FPM と Nginx を起動
php-fpm -D
nginx -g "daemon off;"