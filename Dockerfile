# http://www.net2ftp.com/homepage/help-administrator.html
# http://mewbies.com/how_to_install_net2ftp_web_based_ftp_ssl_client.htm
FROM alpine:latest

ENV NVR net2ftp_v1.3

# Install dependencies.
RUN apk add --update \
      apache2 \
      php \
      php-apache2 \
      php-mysql \
      php-pgsql \
      php-sqlite3 \
      && \
    rm -f /var/cache/apk/*

# # Install net2ftp.
RUN cd /tmp/ && \
    wget http://www.net2ftp.com/download/${NVR}.zip && \
    unzip ${NVR}.zip && \
    mv ${NVR}/* /var/www/localhost/htdocs/ && \
    chown -R root:apache /var/www/localhost/htdocs && \
    rm -fr /tmp/*

COPY php_value.conf /etc/apache2/conf.d/

ENV LANG C
EXPOSE 80

ENTRYPOINT ["apachectl"]
CMD ["-D", "FOREGROUND"]
