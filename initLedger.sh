curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"e0321c0009cc492152cee2c82f2240a2e87461287880ddc214346286f4ba2d9324f6dcf3b8ac686bd2af1821d5b49c99082a70eefdfb548ffbfd3f504eab47bd\"
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