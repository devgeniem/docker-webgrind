# Lightweight PHP-FPM & Nginx Docker Image for running Webgrind
[![devgeniem/alpine-wordpress docker image](http://dockeri.co/image/devgeniem/webgrind)](https://registry.hub.docker.com/u/devgeniem/webgrind/)

[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)
Php5/nginx docker container for [jokkedk/webgrind](https://github.com/jokkedk/webgrind).

You can use this to analyze xdebug profiling.

## Example
You need configure your xdebug to save its cachegrind files into `/tmp/xdebug` and then share that path with webgrind container.

```yaml
##
# Web Server which runs nginx+php
##
web:
  image: devgeniem/wordpress-development-server
  ports:
    - 80
  volumes:
    # For profiling the php site with xdebug
    - /tmp/xdebug

##
# Container for analyzing xdebug profiling
##
webgrind:
  image: devgeniem/webgrind
  ports:
    - 80
  volumes_from:
    - web
```

## Configuration
You can configure following enviromental variables:
```bash
# Timezone
TZ="Europe/Helsinki"

# This is the location where webgrind looks for the xdebug cachegrind files
XDEBUG_OUTPUT_DIR="/tmp/xdebug"

# Here webgrind then stores the temp files after analyzing the results
WEBGRIND_STORAGE_DIR="/tmp/webgrind"

# Internal nginx port number
PORT="80"

# PHP maximum execution time, this needs to be high in order to create the call graphs
PHP_MAX_EXECUTION_TIME="1200"
```

## License
MIT
