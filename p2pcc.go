package main
import (
    "encoding/json"
    "fmt"
    "strconv"
    "errors"
    "github.com/hyperledger/fabric/core/chaincode/shim"
)
type SmartContract struct {
}
type Account struct {
    Name string `json:"name"`
    Risk int    `json:"risk"`
    Type string `json:"type"`
    Fund int    `json:"fund"`
    Loan int    `json:"loan"` //loan given or taken
}
func main() {
    err := shim.Start(new(SmartContract))
    if err != nil {
        fmt.Printf("Error creating new Smart Contract: %s", err)
    }
}

func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface, function string, args []string) ([]byte, error) {
    return nil, nil
}

func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface, function string, args []string) ([]byte, error) {
    if function == "initLedger" {
        return s.initLedger(APIstub, args)
    } else if function == "borrow" {
        return s.borrow(APIstub, args)
    }

    fmt.Println("invoke did not find func: " + function)
    return nil, errors.New("Received unknown function invocation: " + function)
}

func (s *SmartContract) initLedger(APIstub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
    Accounts := []Account{
        Account{Name:"Harrison", Risk:2, Type:"LENDER", Fund:20000, Loan:0},
        Account{Name:"Gibson", Risk:3, Type:"LENDER", Fund:20000, Loan:0},
        Account{Name:"Peter", Risk:2, Type:"BORROWER", Fund:0, Loan:0},
    }

    i := 0
    for i < len(Accounts) {
        fmt.Println("i is ", i)
        accountAsBytes, _ := json.Marshal(Accounts[i])
        APIstub.PutState("ACCOUNT"+strconv.Itoa(i), accountAsBytes)
        fmt.Println("Added", Accounts[i])
        i = i + 1
    }

    return nil, nil
}


func (s *SmartContract) borrow(APIstub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
    //step 1 : define [borrowerId, fundsNeeded, borrowerRisk]
    if len(args) < 2 {
        //return shim.Error("Incorrect number of arguments. Expecting 2")
        return nil, errors.New("Incorrect number of arguments. Expecting 2")
    }
    borrowerId := args[0]

    fundsNeeded, err := strconv.Atoi(args[1]);

    remaining := fundsNeeded

    borrowerAsBytes, _ := APIstub.GetState(borrowerId)
    borrower := Account{}
    json.Unmarshal(borrowerAsBytes, &borrower)
    borrowerRisk := borrower.Risk
    borrower.Loan = fundsNeeded
    

    //step 2 : get [borrowerRisk,matchedLenders]
    queryString := fmt.Sprintf("{\"selector\":{\"Type\":\"%s\"}}", "LENDER")
    tempAry := []string{queryString}
    queryResults, err := s.Query(APIstub,"read", tempAry)
    
    if err != nil {
        return nil, errors.New(err.Error())
        
    }
    
    type LenderStruc struct {
        Key string `json:"Key"`
        Record Account `json:"Record"`
    }
    type LendersStruc []*LenderStruc
    lendersS := LendersStruc{}
    json.Unmarshal(queryResults, &lendersS)

    i := 0
    for i < len(lendersS) {
        key := lendersS[i].Key
        val := lendersS[i].Record

        fmt.Println("for lender ", key)
        fmt.Println("risk", val.Risk)
        if val.Risk<= borrowerRisk {
            if val.Fund < 0 {
                fmt.Println("possible funding", key)
                toTransfer := fundsNeeded
                if toTransfer > val.Fund {
                    toTransfer := val.Fund
                    remaining = remaining - toTransfer
                    //substep1: take from lender & update lender
                    lenderAsBytes, _ := APIstub.GetState(key)
                    lender := Account{}
                    json.Unmarshal(lenderAsBytes, &lender)
                    lender.Fund = lender.Fund - toTransfer
                    lender.Loan = lender.Loan + toTransfer
                    if val.Fund == 0 {
                        if val.Risk != 1 {
                            lender.Risk = lender.Risk - 1
                        }
                    }
                    lenderAsBytes, _ = json.Marshal(lender)
                    APIstub.PutState(args[0], lenderAsBytes)

                    //substep2: give to borrower & dont update borrower yet
                    borrower.Fund = borrower.Fund + toTransfer
                }
            }
        }
        i = i + 1
    }

    //step 4 : if remaining = 0 -> change risk of borrower
    if remaining == 0 {
        if borrower.Risk != 3 {
            borrower.Risk = borrower.Risk + 1 
        }
    }
    borrowerAsBytes, _ = json.Marshal(borrower)
    APIstub.PutState(borrowerId, borrowerAsBytes)

    return borrowerAsBytes, nil
}

func (s *SmartContract) Query(stub shim.ChaincodeStubInterface, function string, args []string) ([]byte, error) {
    fmt.Println("query is running " + function)

    if function == "read" {
        return s.read(stub, args)
    } else if function == "readAll" {
        return s.readAll(stub, args)
    }
    fmt.Println("query did not find func: " + function)

    return nil, errors.New("Received unknown function query: " + function)
}
func (s *SmartContract) read(stub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
    var key, jsonResp string
    var err error

    if len(args) != 1 {
        return nil, errors.New("Incorrect number of arguments. Expecting name of the key to query")
    }

    key = args[0]
    valAsbytes, err := stub.GetState(key)
    if err != nil {
        jsonResp = "{\"Error\":\"Failed to get state for " + key + "\"}"
        return nil, errors.New(jsonResp)
    }

    return valAsbytes, nil
}
func (s *SmartContract) readAll(stub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
    var jsonResp string
    var err error

    //key = args[0]
    valAsbytes1, err1 := stub.GetState("ACCOUNT0")
    valAsbytes2, err2 := stub.GetState("ACCOUNT1")
    valAsbytes3, err3 := stub.GetState("ACCOUNT2")

    if err1 != nil {
        jsonResp = "{\"Error\":\"Failed to get state for ACCOUNT0\"}"
        return nil, errors.New(jsonResp)
    }
    if err2 != nil {
        jsonResp = "{\"Error\":\"Failed to get state for ACCOUNT1\"}"
        return nil, errors.New(jsonResp)
    }
    if err3 != nil {
        jsonResp = "{\"Error\":\"Failed to get state for ACCOUNT3\"}"
        return nil, errors.New(jsonResp)
    }

    //var b []byte
    valAsbytes := []byte(string(valAsbytes1)+ string(valAsbytes2) + string(valAsbytes3))
    
    return valAsbytes, nil
}
