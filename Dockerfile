# http://www.net2ftp.com/homepage/help-administrator.html
# http://mewbies.com/how_to_install_net2ftp_web_based_ftp_ssl_client.htm
FROM httpd:2-alpine

ENV NVR net2ftp_v1.3

# Install dependencies.
RUN apk add --update \
      php \
      php-apache2 \
      php-sqlite3 \
      && \
    rm -f /var/cache/apk/*

# # Install net2ftp.
RUN cd /tmp/ && \
    wget http://www.net2ftp.com/download/${NVR}.zip && \
    unzip ${NVR}.zip -d htdocs \
    chown -R root:apache /var/www/localhost/htdocs && \
    rm -fr /tmp/*

COPY php_value.conf /etc/apache2/conf.d/

ENV LANG C
EXPOSE 80
