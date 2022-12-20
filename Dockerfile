FROM nginx:1.23.3-alpine-slim

# Install the openssl package
RUN apk update && apk add openssl

# Create a directory for the script and the certificates
RUN mkdir -p /etc/nginx/ssl

# Copy the script that generates the SSL certificates
COPY generate-certs.sh /usr/local/bin/generate-certs.sh

# Make the script executable
RUN chmod +x /usr/local/bin/generate-certs.sh

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 and 443
EXPOSE 80 443

# Set the entrypoint to the script that generates the SSL certificates
ENTRYPOINT ["/usr/local/bin/generate-certs.sh"]

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
