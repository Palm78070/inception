FROM debian:buster

# openssl option
# req used to generate certificate signing request(CSR) + self-signed certificate
# -x509 tells OpenSSL to generate self-signed certificate not CSR
# -nodes not encrypt private key with passphrase, not protected by PW store in plaintext
# -days specifies number of days cert should be valid
# -newkey specifies new private key should be generated rsa:2048 to generate RSA key with length of 2048 bits
# -keyout specifies file where private key should be stored -out specifies file cert should be stored
# -subj specifies subject of cert C=country L=location O=organization OU=organization unit CN=common name
RUN apt-get -y update && apt-get -y upgrade \
	&& apt update -y && apt upgrade -y \
	&& apt install -y nginx && apt install openssl -y \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=TH/L=BKK/O=42/OU=cardet/CN=rthammat(http://rthammat.42.fr/)"
