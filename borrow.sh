curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"4557f385621d702253106e7d91724e9f37e8c096334a3d2ceba62d10485898b7dd7af7f1f9594536498d7c2ad107b07021497a513f21bf906652eb13785221d1\"
    },
    \"ctorMsg\": {
      \"function\": \"borrow\",
      \"args\": [
        \"ACCOUNT2\",
        \"50000\"
      ]
    },
    \"secureContext\": \"user_type1_0\"
  },
  \"id\": 0
}" "https://a9e6757e41d64d8286f2e02d126c191a-vp0.us.blockchain.ibm.com:5002/chaincode"