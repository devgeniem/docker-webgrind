FROM onnimonni/alpine-base:3.4
MAINTAINER Onni Hakala - Geniem Oy. <onni.hakala@geniem.com>

# Add few options which can be overridden
ENV \
    TZ="Europe/Helsinki" \
    # Webgrind options
    XDEBUG_OUTPUT_DIR="/tmp/xdebug" \
    WEBGRIND_STORAGE_DIR="/tmp/webgrind" \
    # nginx/php-fpm configs
    WEB_ROOT="/var/www/webgrind" \
    PORT="80" \
    PHP_MAX_EXECUTION_TIME="1200"

# Install php5, nginx and webgrind
RUN apk add --no-cache git \
    # Nginx for running web server
    nginx \

    # PHP 5.X and webgrind dependency libraries
    php5 php5-fpm php5-json \

    # Python and Graphviz for function call graphs
    python graphviz && \

    # Install webgrind
    git clone --depth=1 --branch=master https://github.com/jokkedk/webgrind $WEB_ROOT && \
    rm -rf $WEB_ROOT/.git && \

    # Remove git after installation
    apk del git && \

    # Remove default nginx folders, cache and tmp files
    rm -rf /var/www/localhost && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

RUN \
    # Small fixes to php & nginx
    ln -s /etc/php5 /etc/php && \
    ln -s /usr/lib/php5 /usr/lib/php && \

    # Create default PROFILER DIR
    mkdir -p $WEBGRIND_STORAGE_DIR && \
    chown nginx:www-data $WEBGRIND_STORAGE_DIR

##
# Add Project files like nginx and php-fpm processes and configs
# Also custom scripts and bashrc
##
COPY rootfs/ /

EXPOSE ${PORT}

ENTRYPOINT ["/init"]
