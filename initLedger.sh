curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"307475767e213ed274e0cbd143537049545ac6bb3ed471d18e861cdfdbcc8b5d3063bcea224ce192cf9ebd27651a0b6f790bf8b9384e5ef07f2f52921adeda37\"
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