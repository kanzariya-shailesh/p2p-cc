#### Chain code of the P2P Lending Application
#### Commands to clean up everything and do fresh setup of the application
clear && sudo git add . && sudo git commit -m 'removed accounts on init' && sudo git push origin master && clear && sudo sh deploy.sh && sudo sh initLedger.sh && sudo sh borrow.sh && clear && sudo sh readAll.sh

#### HTTP POST body samples to invoke different transactions
#### //deploy chaincode 
```json
{
  "jsonrpc": "2.0",
  "method": "deploy",
  "params": {
    "type": 1,
    "chaincodeID": {
      "path": "https://github.com/kanzariya-shailesh/p2p-cc"
    },
    "ctorMsg": {
      "function": "init",
      "args": [
        "string"
      ]
    },
    "secureContext": "user_type1_0"
  },
  "id": 5
}
```
#### //invoke -> initLedger
``` json
{
  "jsonrpc": "2.0",
  "method": "invoke",
  "params": {
    "type": 1,
    "chaincodeID": {
      "name": "1a76d4f038850660d9d053482375604bb53eb32c9678a4c9acd769e4aaae0fc8d16aa218c58ba9b440d905315f165b34934ca819db8030a73777fe4ba6ee4de8"
    },
    "ctorMsg": {
      "function": "initLedger",
      "args": [
      ]
    },
    "secureContext": "user_type1_0"
  },
  "id": 0
}
```
#### //invoke -> borrow
``` json
{
  "jsonrpc": "2.0",
  "method": "invoke",
  "params": {
    "type": 1,
    "chaincodeID": {
      "name": "1a76d4f038850660d9d053482375604bb53eb32c9678a4c9acd769e4aaae0fc8d16aa218c58ba9b440d905315f165b34934ca819db8030a73777fe4ba6ee4de8"
    },
    "ctorMsg": {
      "function": "borrow",
      "args": [
        "ACCOUNT2",
        "500"
      ]
    },
    "secureContext": "user_type1_0"
  },
  "id": 0
}
```
#### //query -> read all query
```json
{
  "jsonrpc": "2.0",
  "method": "query",
  "params": {
    "type": 1,
    "chaincodeID": {
      "name": "1a76d4f038850660d9d053482375604bb53eb32c9678a4c9acd769e4aaae0fc8d16aa218c58ba9b440d905315f165b34934ca819db8030a73777fe4ba6ee4de8"
    },
    "ctorMsg": {
      "function": "readAll",
      "args": [
        "ACCOUNT1"
      ]
    },
    "secureContext": "user_type1_0"
  },
  "id": 0
}
```
#### //query -> read query
``` json
{
  "jsonrpc": "2.0",
  "method": "query",
  "params": {
    "type": 1,
    "chaincodeID": {
      "name": "1a76d4f038850660d9d053482375604bb53eb32c9678a4c9acd769e4aaae0fc8d16aa218c58ba9b440d905315f165b34934ca819db8030a73777fe4ba6ee4de8"
    },
    "ctorMsg": {
      "function": "read",
      "args": [
        "ACCOUNT1"
      ]
    },
    "secureContext": "user_type1_0"
  },
  "id": 0
}
```
