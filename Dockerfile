# Dockerfile
FROM php:8.2-apache

# Copy project files to Apache's root folder
COPY . /var/www/html/

# Enable Apache mod_rewrite if needed
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80
