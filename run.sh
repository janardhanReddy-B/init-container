#!/bin/bash

if [ "$skip_schema" == "true" ]; then
  echo "Skipping Schema"
  exit
fi

if [ "$dbtype" == "mysql" ]; then
  git clone https://github.com/janardhanReddy-B/shipping
  cd shipping/schema
  echo "GRANT ALL ON cities.* TO 'shipping'@'%' IDENTIFIED BY 'secret';" | mysql -h prod-rds.cluster-cajpnbnycbmh.us-east-1.rds.amazonaws.com -u$dbuser -p$dbpass
  mysql -h prod-rds.cluster-cajpnbnycbmh.us-east-1.rds.amazonaws.com -u$dbuser -p$dbpass <shipping.sql
fi

if [ "$dbtype" == "mongo" ]; then
  git clone https://github.com/janardhanReddy-B/$component
  cd component/schema
  curl -L -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
  mongo --ssl --host prod-docdb.cluster-cajpnbnycbmh.us-east-1.docdb.amazonaws.com:27017 --sslCAFile global-bundle.pem --username $dbuser --password $dbpass3 < $component.js
fi
