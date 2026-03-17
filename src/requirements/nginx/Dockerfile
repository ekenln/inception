FROM debian:bookworm

RUN apt update -y && apt upgrade -y && \
apt install -y nginx && \
apt install -y openssl && \
apt install -y curl

RUN mkdir -p /etc/nginx/ssl

# change the CN to eeklund.42.nl /fr later!
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=NL/ST=IDF/L=Amsterdam/O=42/OU=42/CN=localhost/UID=eeklund"

RUN mkdir -p /var/run/nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/wordpress /var/run/nginx && \
    chmod 755 /var/www/wordpress && \
    chown -R www-data:www-data /var/www/wordpress

EXPOSE 8443

CMD [ "nginx", "-g", "daemon off;" ]