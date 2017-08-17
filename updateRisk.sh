curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"afcb0094ba0ad22f0500e26badc8e24c5abdcdb6441f182faf340e646e3bc714ad709ad09f39d56f83849d51432fd5dd3e43124ffbe7a6f8a6f0a4655e6b4b37\"
    },
    \"ctorMsg\": {
      \"function\": \"updateRisk\",
      \"args\": [
        \"ACCOUNT0\",
        \"2\",
        \"1\"
      ]
    },
    \"secureContext\": \"user_type1_0\"
  },
  \"id\": 0
}" "https://a9e6757e41d64d8286f2e02d126c191a-vp0.us.blockchain.ibm.com:5002/chaincode"