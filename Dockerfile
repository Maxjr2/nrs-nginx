FROM nginx:alpine-slim

# Install the openssl package
RUN apk update && apk add openssl

# Copy the script that generates the SSL certificates
COPY generate-certs.sh /usr/local/bin/generate-certs.sh

# Make the script executable
RUN chmod +x /usr/local/bin/generate-certs.sh

# Copy the Nginx configuration files from the proxy-config directory
COPY proxy-config /etc/nginx/conf.d/

# Expose port 80 and 443
EXPOSE 80 443

# Set the entrypoint to the script that generates the SSL certificates
ENTRYPOINT ["/usr/local/bin/generate-certs.sh"]

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
