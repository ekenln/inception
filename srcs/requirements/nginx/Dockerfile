FROM debian:bookworm

RUN apt update -y && apt upgrade -y && \
apt install -y nginx && \
apt install -y openssl && \
apt install -y curl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=NL/L=Amsterdam/O=42/OU=42/CN=eeklund.42.fr/UID=eeklund"

RUN mkdir -p /var/run/nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/run/nginx

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]