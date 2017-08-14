curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"query\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"d015207a3272f5eb2487b7118d5aca96d5f33f4fd01f481ac9b53864fdf08c0e2aa7373dd0a3e70d9caaaa0c7a1ec72a1577768659fc20c868680f2a8c39d089\"
    },
    \"ctorMsg\": {
      \"function\": \"readAll\",
      \"args\": [
        \"ACCOUNT1\"
      ]
    },
    \"secureContext\": \"user_type1_0\"
  },
  \"id\": 0
}" "https://a9e6757e41d64d8286f2e02d126c191a-vp0.us.blockchain.ibm.com:5002/chaincode"