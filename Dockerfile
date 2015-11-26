#
# Nasqueron - Cachet image
#

FROM nasqueron/nginx-php-fpm:novolume
MAINTAINER Sébastien Santoro aka Dereckson <dereckson+nasqueron-docker@espace-win.org>

#
# Prepare the container
#

USER app
WORKDIR /var/wwwroot/default

RUN git init && git remote add origin https://github.com/cachethq/Cachet.git && \
    git fetch && git checkout -t origin/master && \
    wget https://raw.githubusercontent.com/nasqueron/docker-cachet/master/.env && \
    composer install --no-dev -o && \
    php artisan migrate && \
    php artisan key:generate && \
    php artisan config:cache

#
# Run the container
#

USER root
