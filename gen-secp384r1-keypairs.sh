openssl ecparam -name secp384r1 -genkey -noout -out data/new-secp384r1-private-key.pem
openssl ec -in data/new-secp384r1-private-key.pem -pubout -outform DER -out data/new-secp384r1-public-key.der
