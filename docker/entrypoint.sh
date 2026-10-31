#!/bin/bash

# Renderから指定されたPORTをNginxの設定に反映
sed -i "s/listen 10000;/listen ${PORT:-10000};/g" /etc/nginx/sites-available/default

# ストレージおよびキャッシュのディレクトリを確実に作成し権限を付与
mkdir -p storage/framework/cache/data
mkdir -p storage/framework/sessions
mkdir -p storage/framework/views
mkdir -p storage/logs
chmod -R 775 storage bootstrap/cache

# 先にキャッシュをクリアして環境変数を確実に読み込ませる
php artisan config:clear

# データベースのマイグレーションを自動実行
php artisan migrate --force

# その後に最適化・キャッシュ生成を行う
php artisan config:cache
php artisan route:cache
php artisan view:cache

# PHP-FPM と Nginx を起動
php-fpm -D
nginx -g "daemon off;"