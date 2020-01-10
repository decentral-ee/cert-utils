#!/bin/bash

set -ex

openssl pkeyutl -derive -inkey data/new-secp384r1-private-key.pem -peerkey data/XYZ-pin1-public-key.pem | xxd -p | tr '\n' '|' | sed 's/|//g'
echo
pkcs11-tool --derive --token-label PIN1 --login --id 01 -m ECDH1-DERIVE --input-file data/new-secp384r1-public-key.der --output-file >(xxd -p | tr '\n' '|' | sed 's/|//g')
