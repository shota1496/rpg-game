FROM php:8.4-fpm

# 必要なパッケージとPHP拡張機能のインストール
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    zip \
    unzip \
    nginx \
    supervisor

# PHP拡張機能の有効化（PostgreSQL/MySQL両対応）
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd

# Composerのインストール
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 作業ディレクトリの設定
WORKDIR /var/www/html

# プロジェクトファイルをコンテナにコピー
COPY . .

# Composerで本番用ライブラリのインストール
RUN composer install --no-dev --optimize-autoloader --no-interaction

# ストレージ等のパーミッション設定
#RUN chmod -R 775 storage bootstrap/cache
# ストレージおよびキャッシュディレクトリの作成とパーミッション設定
RUN mkdir -p storage/framework/views storage/framework/cache storage/framework/sessions && chmod -R 775 storage bootstrap/cache


# Nginxの設定ファイルをコピー（後述）
COPY docker/nginx.conf /etc/nginx/sites-available/default

# 起動用スクリプトのコピーと実行権限付与
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 10000

ENTRYPOINT ["entrypoint.sh"]
