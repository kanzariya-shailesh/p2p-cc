package main
import (
    "bytes"
    "encoding/json"
    "fmt"
    "strconv"

    "github.com/hyperledger/fabric/core/chaincode/shim"
    //sc "github.com/hyperledger/fabric/protos/peer"
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

//func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface, function string, args []string) ([]byte, error) {
    //return shim.Success(nil)
    return nil, nil
}

//func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface, function string, args []string) ([]byte, error) {
    //function, args := APIstub.GetFunctionAndParameters()

    if function == "initLedger" {
        return s.initLedger(APIstub, args)
    } else if function == "borrow" {
        return s.borrow(APIstub, args)
    } else if function == "readAccount" {
        return s.readAccount(APIstub, args)
    } //else if function == "query" {
      //  return s.query(APIstub, args)
    //}

    fmt.Println("invoke did not find func: " + function)
    //return shim.Error("Invalid Smart Contract function name.")
    return nil, errors.New("Received unknown function invocation: " + function)
}

//func (s *SmartContract) initLedger(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
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

    //return shim.Success(nil)
    return nil, nil
}

//func (s *SmartContract) readAccount(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
func (s *SmartContract) readAccount(APIstub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
    if len(args) != 1 {
        //return shim.Error("Incorrect number of arguments. Expecting 1")
        return nil, errors.New("Incorrect number of arguments. Expecting 1")
    }

    accountAsBytes, _ := APIstub.GetState(args[0])
    //return shim.Success(accountAsBytes)
    return accountAsBytes, nil
}

//func (s *SmartContract) borrow(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
func (s *SmartContract) borrow(APIstub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
    //step 1 : define [borrowerId, fundsNeeded, borrowerRisk]
    if len(args) < 2 {
        //return shim.Error("Incorrect number of arguments. Expecting 2")
        return nil, errors.New("Incorrect number of arguments. Expecting 2")
    }
    borrowerId := args[0]

    fundsNeeded, err := strconv.Atoi(args[1]);

    //fundsNeeded := args[1]
    remaining := fundsNeeded

    borrowerAsBytes, _ := APIstub.GetState(borrowerId)
    borrower := Account{}
    json.Unmarshal(borrowerAsBytes, &borrower)
    borrowerRisk := borrower.Risk
    //update loan ammount for borrower
    borrower.Loan = fundsNeeded
    

    //step 2 : get [borrowerRisk,matchedLenders]
    queryString := fmt.Sprintf("{\"selector\":{\"Type\":\"%s\"}}", "LENDER")
    queryResults, err := getQueryResultForQueryString(APIstub, queryString)
    if err != nil {
        //return shim.Error(err.Error())
        return nil, errors.New(err.Error())
        
    }
    
    type LenderStruc struct {
        Key string `json:"Key"`
        Record Account `json:"Record"`
    }
    type LendersStruc []*LenderStruc
    lendersS := LendersStruc{}
    json.Unmarshal(queryResults, &lendersS)

    //lenders := queryResults
    //lendersStr := string(lenders)
    //lendersObj, err := base64.StdEncoding.DecodeString(lenders)

    //return shim.Success(lenders)

    //step 3 : for each matchLender -> transfer fund, maintain remaningLoan, if lendedFundByLender = 50% his fund -> change risk
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
                    //transer
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
        //carAsBytes, _ := json.Marshal(cars[i])
        //APIstub.PutState("CAR"+strconv.Itoa(i), carAsBytes)
        //fmt.Println("Added", cars[i])
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

    //return shim.Success(borrowerAsBytes)
    return borrowerAsBytes, nil
}

//func (s *SmartContract) query(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
/*func (s *SmartContract) query(APIstub shim.ChaincodeStubInterface, function string, args []string) ([]byte, error) {
    if len(args) < 1 {
        return shim.Error("Incorrect number of arguments. Expecting 1")
    }

    queryString := args[0]

    queryResults, err := getQueryResultForQueryString(APIstub, queryString)
    if err != nil {
        return shim.Error(err.Error())
    }
    return shim.Success(queryResults)
}*/


func getQueryResultForQueryString(APIstub shim.ChaincodeStubInterface, queryString string) ([]byte, error) {
    fmt.Printf("- getQueryResultForQueryString queryString:\n%s\n", queryString)

    resultsIterator, err := APIstub.GetQueryResult(queryString)
    if err != nil {
        return nil, err
    }
    defer resultsIterator.Close()

    // buffer is a JSON array containing QueryRecords
    var buffer bytes.Buffer
    buffer.WriteString("[")

    bArrayMemberAlreadyWritten := false
    for resultsIterator.HasNext() {
        queryResponse, err := resultsIterator.Next()
        if err != nil {
            return nil, err
        }
        // Add a comma before array members, suppress it for the first array member
        if bArrayMemberAlreadyWritten == true {
            buffer.WriteString(",")
        }
        buffer.WriteString("{\"Key\":")
        buffer.WriteString("\"")
        buffer.WriteString(queryResponse.Key)
        buffer.WriteString("\"")

        buffer.WriteString(", \"Record\":")
        // Record is a JSON object, so we write as-is
        buffer.WriteString(string(queryResponse.Value))
        buffer.WriteString("}")
        bArrayMemberAlreadyWritten = true
    }
    buffer.WriteString("]")

    fmt.Printf("- getQueryResultForQueryString queryResult:\n%s\n", buffer.String())

    return buffer.Bytes(), nil
}

func (s *SmartContract) Query(stub shim.ChaincodeStubInterface, function string, args []string) ([]byte, error) {
    fmt.Println("query is running " + function)

    // Handle different functions
    if function == "read" { //read a variable
        return s.read(stub, args)
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
