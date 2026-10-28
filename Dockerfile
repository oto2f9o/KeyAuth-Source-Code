FROM php:8.1-apache

# Sao chép trực tiếp file script bạn vừa tạo trên GitHub vào hệ thống Docker
COPY install-php-extensions /usr/local/bin/

# Cài đặt thêm mysqli cùng pdo_mysql và redis cho hệ thống KeyAuth
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions mysqli pdo_mysql redis

# Bật mod_rewrite của Apache để xử lý các đường dẫn API
RUN a2enmod rewrite

# Sao chép mã nguồn toàn bộ dự án vào thư mục chạy của Apache
COPY . /var/www/html/

# Phân quyền cho máy chủ web
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80
