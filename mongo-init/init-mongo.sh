#!/bin/sh
set -e

echo "Waiting for MongoDB to become ready..."

until mongosh --host mongo --eval "db.adminCommand('ping')" >/dev/null 2>&1; do
  sleep 2
done

echo "MongoDB is ready."
echo "Importing seed data..."

mongoimport \
  --host mongo \
  --db employees_DB \
  --collection employees \
  --file /seed/MOCK_DATA.json \
  --jsonArray \
  --drop

echo "Creating unique index on emp_id..."
mongosh mongodb://mongo:27017/employees_DB \
  --eval 'db.employees.createIndex({emp_id:1},{unique:true})'

echo "Creating unique index on first_name + last_name..."
mongosh mongodb://mongo:27017/employees_DB \
  --eval 'db.employees.createIndex({first_name:1,last_name:1},{unique:true})'

echo "MongoDB initialization completed successfully."
