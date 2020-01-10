#!/bin/bash

set -ex
source .env

# rsa key
openssl genrsa -out data/csr-$CERT_NAME-key.pem 4096

# csr
openssl req -new \
    -key data/csr-$CERT_NAME-key.pem \
    -subj "/C=$CERT_C/ST=$CERT_ST/L=$CERT_L/O=$CERT_O/emailAddress=$CERT_EMAIL/CN=$CERT_CN" \
    -out data/csr-$CERT_NAME-req.pem
openssl req -in data/csr-$CERT_NAME-req.pem -text -noout
