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

# Variable del creador (por si acaso funciona el script base)
ENV PHP_MEM_LIMIT -1

# FORZADO DE MEMORIA PARA PHP-FPM
# Buscamos dónde FPM declara los límites por defecto y los reemplazamos directamente por ilimitado (-1)
# También lo añadimos a conf.d para la consola
RUN echo "memory_limit=-1" > /usr/local/etc/php/conf.d/memory-limit.ini && \
    sed -i 's/memory_limit = 128M/memory_limit = -1/g' /usr/local/etc/php/php.ini || true && \
    sed -i 's/php_admin_value\[memory_limit\] = 128M/php_admin_value\[memory_limit\] = -1/g' /usr/local/etc/php-fpm.d/www.conf || true

CMD ["/start.sh"]
