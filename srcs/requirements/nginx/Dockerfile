FROM alpine:3.21

RUN apk update && apk add nginx

#copy config file but where should it go to? 
COPY conf/nginx.conf ./conf/nginx.conf


# Expose port 8080
EXPOSE 443

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]