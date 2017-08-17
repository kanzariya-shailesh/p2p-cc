package main

import (
	"errors"
	"fmt"
	"encoding/json"
	//"strconv"
	//"encoding/json"
	//"time"
	//"strings"
	"github.com/hyperledger/fabric/core/chaincode/shim"
)
var logger = shim.NewLogger("simplecc")
// SimpleChaincode example simple Chaincode implementation
type SimpleChaincode struct {
}

type Account struct {
    Name string `json:"name"`
    Risk int    `json:"risk"`
    Type string `json:"type"`
    Fund int    `json:"fund"`
    Loan int    `json:"loan"` //loan given or taken
    Auto bool    `json:"auto"`
}

func main() {
	err := shim.Start(new(SimpleChaincode))

	if err != nil {
		fmt.Printf("Error starting Simple chaincode: %s", err)
	}
}
func (t *SimpleChaincode) Init(stub shim.ChaincodeStubInterface, function string, args []string) ([]byte, error) {

	return nil, nil
}

func (t *SimpleChaincode) Invoke(stub shim.ChaincodeStubInterface, function string, args []string) ([]byte, error) {
	
	//fmt.Println("invoke is running " + function)
	logger.Warning("invoke is running" + function)
	if function == "set_user" {
	        return t.set_user(stub, args)
	} else if function == "transfer" {
		return t.transfer(stub, args)
	}
	return nil, errors.New("Received unknown function invocation: " + function)
}

func (t *SimpleChaincode) Query(stub shim.ChaincodeStubInterface, function string, args []string) ([]byte, error) {
	fmt.Println("query is running " + function)
	return nil, errors.New("Received unknown function query: " + function)
}

func (t *SimpleChaincode) transfer(stub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
	//fmt.Println("set user called")
	logger.Warning("transfer called")
	val := Account{Name:"Gibson", Risk:2, Type:"LENDER", Fund:100, Loan:0,Auto:false}
	valAsBytes, _ := json.Marshal(val)
	stub.PutState("key2", valAsBytes)

	return nil, nil
}

func (t *SimpleChaincode) set_user(stub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
	//fmt.Println("set user called")
	logger.Warning("set user called")
	val := Account{Name:"Harrison", Risk:2, Type:"LENDER", Fund:20000, Loan:0,Auto:false}
	valAsBytes, _ := json.Marshal(val)
	stub.PutState("key1", valAsBytes)

	var test []string
	t.Invoke(stub, "transfer",test)
	return nil, nil
}
