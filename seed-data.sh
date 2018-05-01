#!/bin/bash

echo "Register Buyer: Workshop coffee"

# 
# Buyers
# 
BUYER001=$(curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
   "$class": "org.coffeechain.Buyer",
   "buyerId": "b001",
   "firstName": "Workshop Coffee",
   "lastName": " "
 }' \
'http://localhost:3000/api/org.coffeechain.Buyer'
)
echo $BUYER001

echo "Register Buyer: Coffee Housecoffee"

BUYER002=$(curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
   "$class": "org.coffeechain.Buyer",
   "buyerId": "b002",
   "firstName": "The Coffee House",
   "lastName": " "
 }' \
'http://localhost:3000/api/org.coffeechain.Buyer'
)
echo $BUYER002

# 
# Growers
# 
echo "Register Grower: Ty"
GROWER_001=$(curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.Grower",
  "growerId": "g001",
  "firstName": "Ty Farm",
  "lastName": " ",
  "farmName": "Ty Farm Co.",
  "farmAltitude": 1500,
  "farmRegion": "Dalat",
  "coffeeTypes": ["Arabica","Robusta"]
}' \
'http://localhost:3000/api/org.coffeechain.Grower'
)
echo $GROWER_001

echo "Register Grower: Teo"
GROWER_002=$(curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.Grower",
  "growerId": "g002",
  "firstName": "Teo Farm",
  "lastName": " ",
  "farmName": "Teo Farm Co.",
  "farmAltitude": 1000,
  "farmRegion": "Buon Me Thuoc",
  "coffeeTypes": ["Arabica","Robusta"]
}' \
'http://localhost:3000/api/org.coffeechain.Grower'
)
echo $GROWER_002

# 
# Regulator
# 
echo "Register Regulator: VietGAP"
REGULATOR_001=$(curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.Regulator",
  "regulatorId": "r001",
  "regulatorOrgName": "VietGAP"
}' \
'http://localhost:3000/api/org.coffeechain.Regulator'
)
echo $REGULATOR_001

# 
# Issue a Certificate
# 
echo "Give certificate to grower g001"
CERT001=$(curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.IssueCertificate",
  "issuer": "r001",
  "grower": "g001",
  "valid": true,
  "certificateId": "cer001",
  "description": "QC"
}' \
'http://localhost:3000/api/org.coffeechain.IssueCertificate'
)
echo $CERT001

#
# Make a request asset
# 
echo "Create first request"
REQ001=$(curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.Request",
  "requestId": "req001",
  "coffeeType": "Arabica",
  "quantityInKg": 10,
  "maxPrice": 250000,
  "region": "Dalat",
  "dateToReceive": "2018-04-30T05:12:01.340Z",
  "buyer": "b001"
}' \
'http://localhost:3000/api/org.coffeechain.Request'
)
echo $REQ001

echo "Create second request"
REQ002=$(curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.Request",
  "requestId": "req002",
  "coffeeType": "Mixed",
  "quantityInKg": 20,
  "maxPrice": 250000,
  "region": "NA",
  "dateToReceive": "2018-04-30T05:12:01.340Z",
  "buyer": "b001"
}' \
'http://localhost:3000/api/org.coffeechain.Request'
)
echo $REQ002


#
# Give offer to first request
# 
echo "Create first request"
OFFER001=$(curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.Offer",
  "offerId": "offer001",
  "price": 249000,
  "accepted": "false",
  "request": "req001",
  "grower": "g001"
}' \
'http://localhost:3000/api/org.coffeechain.Offer'
)
echo $OFFER001

# Accept the first offer

ACCEPTOFFER001=$(curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{
  "$class": "org.coffeechain.AcceptOffer",
  "offer": "offer001",
  "timestamp": "2018-05-01T02:48:01.912Z"
}' \
'http://localhost:3000/api/org.coffeechain.AcceptOffer'
)
echo $OFFER001