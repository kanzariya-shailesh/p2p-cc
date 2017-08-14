curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"query\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"1db439118985d8136a21d7605b799f63cc0f21ae8eea86f99e99a54fbf880844dad5edd4cf187540b2c8313b028ae92b0d2012e111e7dc9211329d9de6e87a28\"
    },
    \"ctorMsg\": {
      \"function\": \"readAll\",
      \"args\": [
        \"ACCOUNT1\"
      ]
    },
    \"secureContext\": \"user_type1_0\"
  },
  \"id\": 0
}" "https://a9e6757e41d64d8286f2e02d126c191a-vp0.us.blockchain.ibm.com:5002/chaincode"