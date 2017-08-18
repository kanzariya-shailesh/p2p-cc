curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"deploy\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"path\": \"https://github.com/kanzariya-shailesh/p2p-cc\"
    },
    \"ctorMsg\": {
      \"function\": \"init\",
      \"args\": [
        \"string\"
      ]
    },
    \"secureContext\": \"user_type1_0\"
  },
  \"id\": 5
}" "https://a9e6757e41d64d8286f2e02d126c191a-vp0.us.blockchain.ibm.com:5002/chaincode"
