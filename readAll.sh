curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"query\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"6ca414f732a10d2026612c79abe5ff08b8ff17d9004d031f0bb95f97cb12bbb2276fb735c2a0e6219e1524eb213d9d6e52f672d0549d1a2854be1a5d9eb5770a\"
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