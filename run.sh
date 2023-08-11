#!/bin/bash

if [ "$skip_schema" == "true" ]; then
  echo "Skipping Schema"
  exit
fi

if [ "$dbtype" == "mysql" ]; then
  git clone https://github.com/janardhanReddy-B/shipping
  cd shipping/schema
  echo "GRANT ALL ON cities.* TO 'shipping'@'%' IDENTIFIED BY 'secret';" | mysql -h $dbhost -u$dbuser -p$dbpass
  mysql -h $dbhost -u$dbuser -p$dbpass <shipping.sql
fi

if [ "$dbtype" == "mongo" ]; then
  git clone https://github.com/janardhanReddy-B/$component
  cd $component/schema
  curl -L -O https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
  mongo --ssl --host $dbhost:27017 --sslCAFile rds-combined-ca-bundle.pem --username $dbuser --password $dbpass < $component.js
fi
