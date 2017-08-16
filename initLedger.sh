curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"2a3492abf22cb2f7ae345efdfc7e49ca20e275afdbce7b2af7e42db00fb1a3f8ef101e872b058701a95dae51cb76ee96009fdbdda6c126d771082314798af774\"
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