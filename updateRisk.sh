curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"589a63cf841cc47101770c7bcc559d8314283e8c72348df6a28b7279d21c5b5a462b50f3055593193646ab9da9053da0466aefd2ef14fc7b6116aa19585711f7\"
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