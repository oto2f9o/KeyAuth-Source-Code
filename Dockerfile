FROM php:8.1-apache

# Cài đặt phần mở rộng PDO MySQL và Redis cho PHP
RUN apt-get update && apt-get install -y \
    libpcre3-dev \
    && docker-php-ext-install pdo pdo_mysql \
    && pecl install redis \
    && docker-php-ext-enable redis

# Bật mod_rewrite của Apache để xử lý routing API hệ thống KeyAuth
RUN a2enmod rewrite

# Đồng bộ mã nguồn vào vùng chạy của Apache
COPY . /var/www/html/

# Phân quyền hạn đọc ghi cho server web
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80
