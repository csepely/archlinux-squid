#!/bin/bash
if [[ ! -e "/etc/squid/cert/CA.pem" ]]
then
echo ":: Generating certificate..."
openssl req \
    -new \
    -newkey rsa:2048 \
    -sha256 \
    -days 3650 \
    -nodes \
    -x509 \
    -extensions v3_ca \
    -keyout /etc/squid/cert/CA.pem \
    -out /etc/squid/cert/CA.pem \
    -subj "/C=HU/ST=BAZ/L=Miskolc/O=Arosa Kft./OU=IT/CN=proxy.agw.hu"
# generate browser cert
    openssl x509 -in /etc/squid/cert/CA.pem -outform DER -out /etc/squid/cert/CA.der
else
    echo ":: Using existing certificate..."
fi
# ssl cache
if [[ ! -e "/var/cache/squid/ssl_db" ]]
then
    echo ":: SSL DB init..."
    /usr/lib/squid/security_file_certgen -c -s /var/cache/squid/ssl_db -M 4MB
fi
# squid cache
/usr/sbin/squid -f /etc/squid/squid.conf -N -z
# squid
exec /usr/sbin/squid -YCd 1 -N -f /etc/squid/squid.conf
