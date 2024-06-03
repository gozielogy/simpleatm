import R "mo:base/Result";
import Debug "mo:base/Debug";

actor SimpleAtm {
  
  // Define a record to represent the account
type Account = {
 name: Text;
 balance : Nat;
};
 
// Define a function to create a new account
public func createAccount(accountName: Text) : async Account {
  return { 
    name = accountName;
    balance = 0; 
  };
};

// Define a function to check the balance
public func checkBalance(account : Account) : async Nat {
  return account.balance;
};

// Define a function to deposit money into the account
public func deposit(account : Account, amount : Nat) : async Account {
  Debug.print("Deposit transaction completed");
  return {
    name = account.name; 
    balance = account.balance + amount; 
  };
};

// Define a function to withdraw money from the account
public func withdraw(account : Account, amount : Nat) : async R.Result<Account, Text> {
  if(account.balance >= amount){
    Debug.print("Withdrawal Successful");
    return #ok {
      name = account.name; 
      balance = account.balance - amount; 
    };
  } else {
     // implement withdrawal error functionality
  return #err "Balance not sufficient for transaction"; 
  };
};

 type TransferOperationResult =  {
    #Success : Account;
    #Failure : Text;
  };

// Define a function to update account balance
public func updateBalance (person: Account, newBalance: Nat) : async Account {
  return {person with balance = newBalance};
};

// Define a function to transfer money to another account
public func transfer(fromAccount: Account, toAccount: Account, amount: Nat) : async TransferOperationResult{
  if(fromAccount.balance >= amount) {
    return #Success{
      name = toAccount.name;
      balance = toAccount.balance + amount;
    };
  } else {
    return #Failure "Balance not sufficient for this transfer";
  };
}

};