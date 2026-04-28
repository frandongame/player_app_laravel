FROM richarvey/nginx-php-fpm:latest

COPY . .

# Variables nativas de la imagen
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr
ENV COMPOSER_ALLOW_SUPERUSER 1

# Intentamos con la variable nativa del creador
ENV PHP_MEM_LIMIT -1

# FORZADO DE MEMORIA COMPATIBLE CON ALPINE LINUX
# Busca y reemplaza el límite en cualquier archivo php.ini o www.conf (FPM)
RUN find /etc/ -type f -name "php.ini" -exec sed -i 's/memory_limit = 128M/memory_limit = -1/g' {} + || true && \
    find /etc/ -type f -name "www.conf" -exec sed -i 's/php_admin_value\[memory_limit\] = 128M/php_admin_value\[memory_limit\] = -1/g' {} + || true

CMD ["/start.sh"]
