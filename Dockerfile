FROM php:8.1-apache

# Cài đặt các công cụ build và phần mở rộng cần thiết cho KeyAuth
RUN apt-get update && apt-get install -y \
    libpcre3-dev \
    gcc \
    make \
    autoconf \
    && docker-php-ext-install pdo pdo_mysql \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apt-get clean && rm -rf /var/lib/lists/*

# Bật mod_rewrite của Apache để xử lý các đường dẫn API của KeyAuth
RUN a2enmod rewrite

# Sao chép mã nguồn vào thư mục chạy của Apache
COPY . /var/www/html/

# Phân quyền cho máy chủ web
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80
