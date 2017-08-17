curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"ca0d6eff6e7d0cc12e9e532f4888cb94e3ca8a31880022999eb9c446318194adaf7ab3fc40cf482c3b198785b716c2e0b7df15c505780a136c24bc434d78b86e\"
    },
    \"ctorMsg\": {
      \"function\": \"updateRisk\",
      \"args\": [
        \"ACCOUNT1\",
        \"3\",
        \"0\"
      ]
    },
    \"secureContext\": \"user_type1_0\"
  },
  \"id\": 0
}" "https://a9e6757e41d64d8286f2e02d126c191a-vp0.us.blockchain.ibm.com:5002/chaincode"