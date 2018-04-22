./startFabric.sh

composer archive create --sourceType dir --sourceName coffee-chain
createPeerAdminCard.sh

composer network install --card PeerAdmin@hlfv1 --archiveFile coffee-chain@0.0.1.bna
composer network start --networkName coffee-chain --networkVersion 0.0.1 --networkAdmin admin --networkAdminEnrollSecret adminpw --card PeerAdmin@hlfv1

composer card import -f admin@coffee-chain.card
composer-rest-server 
> admin@coffee-chain
composer-rest-server -c admin@coffee-chain -n always -w true
(composer-rest-server -c admin@coffee-chain -n always -a true -m true -w true)

yo hyperledger-compose