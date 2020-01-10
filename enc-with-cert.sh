#!/bin/bash

function error_exit {
    echo "$1" >&2   ## Send message to stderr. Exclude >&2 if you don't want it that way.
    exit "${2:-1}"  ## Return a code specified by $2 or 1 by default.
}

[ -f "$1" ] || error_exit "First parameter is input file"
[ -f "$2" ] || error_exit "First parameter is cert pem file"
INPUTFILE=$1
CERTPEMFILE=$2

# generate a new key and encrypt the file with it
openssl rand -hex -out $INPUTFILE.enckey 64
openssl enc -aes-256-cbc -salt -in $INPUTFILE -out $INPUTFILE.enc -pass file:$INPUTFILE.enckey

# encrypt the key
# for rsa
#openssl rsautl -encrypt \
#    -inkey <(openssl x509 -in $CERTPEMFILE -noout -pubkey) \
#    -pubin -in $INPUTFILE.enckey -out $INPUTFILE.enckey.enc
