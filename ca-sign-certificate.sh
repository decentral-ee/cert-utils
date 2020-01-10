#!/bin/bash

set -ex
source .env

# cert
openssl x509 \
    -req -in data/csr-$CERT_NAME-req.pem \
    -extensions v3_ca \
    -extfile <(cat <<EOF
[ v3_ca ]
subjectAltName = @alternate_names
[alternate_names]
DNS.1 = $CERT_CN
EOF
    ) \
    -CA data/ca-$CA_NAME-cert.pem -CAkey data/ca-$CA_NAME-key.pem -passin file:data/ca-$CA_NAME-key.pass \
    -CAcreateserial \
    -days 10240 \
    -sha256 \
    -out data/cert-$CERT_NAME.pem
openssl verify -CAfile data/ca-$CA_NAME-cert.pem data/cert-$CERT_NAME.pem
openssl x509 -in data/cert-$CERT_NAME.pem -text -noout

# cert fullchain
cat \
    data/cert-$CERT_NAME.pem \
    data/ca-$CA_NAME-cert.pem \
    > data/cert-$CERT_NAME-full.pem
