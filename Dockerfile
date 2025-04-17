# Use official PHP 8.3 image with Apache
FROM php:8.3-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli \
    && apt-get clean

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Add non-root user and group
RUN groupadd -g 1000 appuser && \
    useradd -u 1000 -g appuser -m -s /bin/bash appuser

# Install Composer globally
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy application source code
COPY . /var/www/html

# Fix permissions: own by non-root user, readable by www-data
RUN chown -R appuser:appuser /var/www/html && \
    chmod -R 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache || true

# Switch to non-root user
USER appuser

# Run composer install as appuser
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Switch back to root so Apache can start properly (it needs to run as www-data)
USER root

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
