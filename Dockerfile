FROM serversideup/php:8.2-fpm-nginx

# Esta imagen acepta PHP_MEMORY_LIMIT de forma nativa y garantizada
ENV PHP_MEMORY_LIMIT=512M

# Laravel config
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV LOG_CHANNEL=stderr

# Composer
ENV COMPOSER_ALLOW_SUPERUSER=1

# Directorio de trabajo
WORKDIR /var/www/html

# Copiar proyecto
COPY --chown=www-data:www-data . .

# Instalar dependencias
RUN composer install --no-dev --optimize-autoloader

# Permisos Laravel
RUN chmod -R 775 storage bootstrap/cache
