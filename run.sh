#!/bin/bash

if [ "$skip_schema" == "true" ]; then
  echo "Skipping Schema"
  exit
fi

git clone https://github.com/janardhanReddy-B/shipping
cd shipping/schema

if [ "mysql" == "mysql" ]; then
  echo "GRANT ALL ON cities.* TO 'shipping'@'%' IDENTIFIED BY 'secret';" | mysql -h rds-prod.cluster-cajpnbnycbmh.us-east-1.rds.amazonaws.com -uroboshop -proboshop123 <shipping.sql
  mysql -h rds-prod.cluster-cajpnbnycbmh.us-east-1.rds.amazonaws.com -uroboshop -proboshop123 <shipping.sql
fi

if [ "$dbtype" == "mongo" ]; then
  curl -L -O https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
  mongo --ssl --host $dbhost:27017 --sslCAFile rds-combined-ca-bundle.pem --username $dbuser --password $dbpass < $component.js
fi
