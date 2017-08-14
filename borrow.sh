curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"1e7be6697995f0d94da4fbb3e67b2e41d28b7dc7e81228fe8a5a83ec9530e78ea5ce37e379c97d88f2b885f0a86be4f3800f976ddd4bd85ab2b9d2cff0038f42\"
    },
    \"ctorMsg\": {
      \"function\": \"borrow\",
      \"args\": [
        \"ACCOUNT2\",
        \"500\"
      ]
    },
    \"secureContext\": \"user_type1_0\"
  },
  \"id\": 0
}" "https://a9e6757e41d64d8286f2e02d126c191a-vp0.us.blockchain.ibm.com:5002/chaincode"