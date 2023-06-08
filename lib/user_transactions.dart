//import 'dart:ffi';

import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import './transaction.dart';

class User_Transaction extends StatefulWidget {
  const User_Transaction({super.key});

  @override
  State<User_Transaction> createState() => _User_TransactionState();
}

class _User_TransactionState extends State<User_Transaction> {
  //initializes a list 
  //2 `Transaction` objects
  //recharge and lunch
  List<Transaction> transactionList = [
    Transaction(
        id: "1", title: "Recharge", amount: 100, dateTime: DateTime.now()),
    Transaction(id: '1', title: "Lunch", amount: 100, dateTime: DateTime.now()),
  ];

  //method creates and adds a new Transaction 
  // transactionList using setState.
  void addTransaction(String title, double amount){
    var transaction = Transaction(id: DateTime.now().toString(), title: title, amount: amount, dateTime: DateTime.now());
    setState(() {
      transactionList.add(transaction);
    });
  }

  @override
  //Column to pass parameters
  //NewTransaction and TransactionList
  Widget build(BuildContext context) {
    return Column(children: [
            NewTransaction(addTransaction),
            TransactionList(transactionList), 
    ],);
  }
}
