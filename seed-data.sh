#!/bin/bash

echo "Register Buyer: Workshop coffee"

curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
   "$class": "org.coffeechain.Buyer",
   "buyerId": "b100",
   "firstName": "Workshop Coffee",
   "lastName": " "
 }' \
'http://localhost:3000/api/org.coffeechain.Buyer'

echo "Register Buyer: Coffee Housecoffee"

curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
   "$class": "org.coffeechain.Buyer",
   "buyerId": "b101",
   "firstName": "The Coffee House",
   "lastName": " "
 }' \
'http://localhost:3000/api/org.coffeechain.Buyer'

