#!/bin/bash

set -ex
source .env

# pass
echo test > data/ca-$CA_NAME-key.pass

# rsa key
openssl genrsa \
    -des3 \
    -out data/ca-$CA_NAME-key.pem \
    -passout file:data/ca-$CA_NAME-key.pass \
    4096

# cert
openssl req \
    -x509 \
    -new -nodes \
    -key data/ca-$CA_NAME-key.pem \
    -passin file:data/ca-$CA_NAME-key.pass \
    -sha256 \
    -days 10240 \
    -subj "/C=$CA_C/ST=$CA_ST/L=$CA_L/O=$CA_O/emailAddress=$CA_EMAIL" \
    -out data/ca-$CA_NAME-cert.pem
openssl x509 -in data/ca-$CA_NAME-cert.pem -text -noout
