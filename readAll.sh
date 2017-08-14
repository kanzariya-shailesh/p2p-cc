curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
  \"jsonrpc\": \"2.0\",
  \"method\": \"query\",
  \"params\": {
    \"type\": 1,
    \"chaincodeID\": {
      \"name\": \"ccf4677092be40859515a26cc31031a232add8bbd48e560a55e48f144e50a2cd8cb9367c2478a6855e4769a5ffc5d1637b290c796847be32a85a799e855e3336\"
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