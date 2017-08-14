curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"d1017b9276d9e0ffbe893e98cdcd0a7d77016f6f5eacda446586669c08335e3836660fc6785f37fda7b580e1aa6a4cb6a1cec817e827a822cb403c3d7ff6059a\"
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