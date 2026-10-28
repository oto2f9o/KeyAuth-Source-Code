FROM php:8.1-apache

# Tải script cài đặt tiện ích mở rộng PHP chính thức (Đoạn này phải liền một dòng duy nhất)
ADD https://github.com/mlocati/docker-php-extension-installer /usr/local/bin/

# Cấp quyền chạy và tự động cài đặt pdo_mysql cùng redis cho hệ thống KeyAuth
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions pdo_mysql redis

# Bật mod_rewrite của Apache để xử lý các đường dẫn API
RUN a2enmod rewrite

# Sao chép mã nguồn vào thư mục chạy của Apache
COPY . /var/www/html/

# Phân quyền cho máy chủ web
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80
