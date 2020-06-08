#!/bin/bash

OUTFILE=nginx/ssl

rm -f $OUTFILE/*

echo "[ req ]
prompt             = no
distinguished_name = lab-ca

[ lab-ca ]
commonName = lab-ca
countryName = FR
organizationName = lab
organizationalUnitName = lab
stateOrProvinceName = lab" >> cert_config

openssl req -x509 -newkey rsa:4096 -keyout $OUTFILE/key-ca.pem -out $OUTFILE/root-ca.pem -days 365 -nodes -config cert_config

rm cert_config

echo "[ req ]
prompt             = no
distinguished_name = lab-registry
req_extensions     = req_ext

[ lab-registry ]
commonName = lab-registry
countryName = FR
organizationName = lab
organizationalUnitName = lab-registry
stateOrProvinceName = lab

[ req_ext ]
subjectAltName = @alt_names
extendedKeyUsage = serverAuth,clientAuth

[alt_names]
DNS.1 = localhost
IP.1 = 127.0.0.1" >> node_cert_config

openssl req \
  -newkey rsa:4096 \
  -keyout $OUTFILE/private_key.pem \
  -out $OUTFILE/lab_cert.csr \
  -nodes \
  -config node_cert_config


openssl x509 \
  -req \
  -in $OUTFILE/lab_cert.csr \
  -CA $OUTFILE/root-ca.pem \
  -CAkey $OUTFILE/key-ca.pem \
  -CAcreateserial \
  -out $OUTFILE/cert.pem \
  -extensions req_ext \
  -extfile node_cert_config \
  -days 365


rm node_cert_config
