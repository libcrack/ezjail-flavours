#!/bin/sh

# Submit the CSR to a Certificate Authority, let them sign it and give you a Certificate
# Combine the certificate, private key (and chain) into a ejabberd compatible PEM file
# Install the certificate in ejabberd

# csr=/etc/ssl/xmpp.libcrack.so.csr
# key=/etc/ssl/private/xmpp.libcrack.so.key
# cert=/etc/ssl/private/xmpp.libcrack.so.pem

csr=/usr/local/etc/ejabberd/xmpp.libcrack.so.csr
key=/usr/local/etc/ejabberd/xmpp.libcrack.so.key
cert=/usr/local/etc/ejabberd/xmpp.libcrack.so.pem

# # Create a Private key and Certificate Signing Request (CSR)
# openssl genrsa -out "$key" 4096
# openssl req -new -key $key -out $csr -utf8 -batch -subj "/C=ES/ST=Andalucia/L=Granada/O=Libcrack/OU=Sistemas/CN=xmpp.libcrack.so"

# # Create a Private key and Certificate Signing Request (CSR)
# # (ONE STEP)
# openssl req -nodes -newkey rsa:2048 -keyout $key -out $csr \
#     -subj "/C=ES/ST=Andalucia/L=Granada/O=Libcrack/OU=Sistemas/CN=xmpp.libcrack.so"
    
# (submit the CSR to a Certificate Authority)
# to get your Certificate. If not...

# Self signed CA signs the created CSR

# Create certificate

# Once you have all the files (private key, certificate and certificate chain), 
# put them all in a folder and continue. We are going to cat all the required 
# files into a ejabberd.pem file.
# 
# This needs to happen in a specific order:
# 
#     private key
#     certificate
#     chains
# 
# So adapt the following commands to your filenames and create the pem file:
#     cat private.key >> ejabberd.pem 
#     cat certificate.pem >> ejabberd.pem 
#     cat chain-1.pem >> ejabberd.pem 
#     cat chain-2.pem >> ejabberd.pem


echo openssl req -new -x509 -newkey rsa:2048 -days 36500 -keyout $key -out $cert \
    -subj "/C=ES/ST=Andalucia/L=Granada/O=Libcrack/OU=Sistemas/CN=xmpp.libcrack.so"
echo openssl rsa -in $key -out $key
echo "cat $key >> $cert"
echo rm $key
echo chown -R ejabberd:ejabberd /usr/local/etc/ejabberd/
echo chmod 400 $cert

echo done
