curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"invoke\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"a13e52fe4f1a5263691f1f841c8cde308abdfbf603c493ea4f84804e61397039969979da34254269dd1725d3e00a433965d67df4a4551e1264b8b55a843989c0\"
    },
    \"ctorMsg\": {
      \"function\": \"borrow\",
      \"args\": [
        \"ACCOUNT2\",
        \"30000\"
      ]
    },
    \"secureContext\": \"user_type1_0\"
  },
  \"id\": 0
}" "https://a9e6757e41d64d8286f2e02d126c191a-vp0.us.blockchain.ibm.com:5002/chaincode"