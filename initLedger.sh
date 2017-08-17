curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"d9897b5ffee1470d8d88cb5269adc68d7ddbe1ea56471d3e3645fb2bc49abfd49f2897a43fd42fc0609785922d99f5e854d3d1e3405ba59b1c66c2c6d2132d79\"
    },
    \"ctorMsg\": {
      \"function\": \"initLedger\",
      \"args\": [
      ]
    },
    \"secureContext\": \"user_type1_0\"
  },
  \"id\": 0
}" "https://a9e6757e41d64d8286f2e02d126c191a-vp0.us.blockchain.ibm.com:5002/chaincode"