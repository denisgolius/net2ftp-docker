# http://www.net2ftp.com/homepage/help-administrator.html
# http://mewbies.com/how_to_install_net2ftp_web_based_ftp_ssl_client.htm
FROM alpine:latest

ENV NVR net2ftp_v1.3

# Install dependencies.
RUN apk add --update \
      apache2 \
      php \
      php-apache2 \
      && \
    rm -f /var/cache/apk/*

# # Install net2ftp.
RUN cd /tmp/ && \
    wget http://www.net2ftp.com/download/${NVR}.zip && \
    unzip ${NVR}.zip && \
    chmod 0777 ${NVR}/files_to_upload/temp && \
    mv -f ${NVR}/files_to_upload/* /var/www/localhost/htdocs/ && \
    rm -fr /tmp/*

COPY php_value.conf /etc/apache2/conf.d/

VOLUME ["/var/www/html/temp"]

ENTRYPOINT ["apachectl"]
CMD ["-D", "FOREGROUND"]
