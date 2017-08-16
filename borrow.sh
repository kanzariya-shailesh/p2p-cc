curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"4a717c6a46afb2ae2c0d23c56cbfa863608cb0bbd8f2f79d7f69de3333e1ac1e6907287158bf7bc1d46eb40e05340b224d66def27b127cfbd8ec4dbe562224c4\"
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