curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"9cdb5ec4318f79963b50d4454d2521283725970613ad8dc11bb1debfac614b90b1527f2894af26e369a94600bbfe8b363e60a4dcaa0c6b6bc530af02515c402d\"
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