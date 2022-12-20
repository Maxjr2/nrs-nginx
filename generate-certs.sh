#!/bin/bash

# Set default values for the O, L, ST, and C attributes
O=${O:-"RTFM"}
L=${L:-"Katzenhirn"}
ST=${ST:-"BY"}
C=${C:-"DE"}

# Generate a self-signed SSL certificate for each missing host in the Nginx configuration files
while read -r host; do
  if [ ! -f /etc/ssl/private/$host.key ] || [ ! -f /etc/ssl/certs/$host.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/$host.key -out /etc/ssl/certs/$host.crt -subj "/CN=$host/OU=$O/O=$L/L=$ST/ST=$C/C=$C"
  fi
done < <(grep -oP "(?<=server_name ).*" /etc/nginx/conf.d/*.conf)
