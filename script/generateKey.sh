#!/bin/bash 

MKCERT_PATH=$(which mkcert)

echo $MKCERT_PATH

if [ $MKCERT_PATH ]
then
    echo "Find mkcert $MKCERT_PATH"
    echo "Start generate key"
    mkcert -install --key-file ./.basic-ssl/_key.pem  --cert-file ./.basic-ssl/_cert.pem '*.104-dev.com.tw' localhost 127.0.0.1 ::1
    echo "Finish generate key"
    
else
    echo "Please install mkcert first"
fi
