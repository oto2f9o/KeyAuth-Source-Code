FROM php:8.1-apache

# Tải trực tiếp script, cấp quyền và cài đặt các phần mở rộng trong cùng 1 lệnh để tránh lỗi vị trí file
RUN apt-get update && apt-get install -y curl && \
    curl -sSL https://github.com/mlocati/docker-php-extension-installer/releases/download/2.12.3/install-php-extensions -o /usr/local/bin/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions pdo_mysql redis

# Bật mod_rewrite của Apache để xử lý các đường dẫn API
RUN a2enmod rewrite

# Sao chép mã nguồn vào thư mục chạy của Apache
COPY . /var/www/html/

# Phân quyền cho máy chủ web
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80
