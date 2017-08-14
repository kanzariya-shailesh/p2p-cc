curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"query\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"8220f2aefa5aa24c0f1c3d236575cbe16e02adeed870d66994cd2b89549d3ca68d11f04e8f9b23f62b3eb6f022047dfaee08635fb295c05d505668fa2f13243f\"
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