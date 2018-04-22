#!/bin/bash

echo "Register Buyer: Workshop coffee"

# 
# Buyers
# 
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

# 
# Growers
# 
echo "Register Grower: Ty"
curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.Grower",
  "growerId": "g001",
  "firstName": "Tyf",
  "lastName": "Tyl",
  "farmName": "Ty Farm Co.",
  "farmAltitude": 1500,
  "farmRegion": "Dalat",
  "coffeeTypes": ["Arabica","Robusta"]
}' \
'http://localhost:3000/api/org.coffeechain.Grower'

echo "Register Grower: Teo"
curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.Grower",
  "growerId": "g002",
  "firstName": "Teof",
  "lastName": "Teol",
  "farmName": "Teo Co.",
  "farmAltitude": 1000,
  "farmRegion": "Buon Me Thuoc",
  "coffeeTypes": ["Arabica","Robusta"]
}' \
'http://localhost:3000/api/org.coffeechain.Grower'

# 
# Regulator
# 
echo "Register Regulator: Ty"
curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.Regulator",
  "regulatorId": "r001",
  "regulatorOrgName": "VietGAP"
}' \
'http://localhost:3000/api/org.coffeechain.Regulator'


