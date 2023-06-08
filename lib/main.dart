import 'package:abc/chart.dart';
import 'package:abc/new_transaction.dart';
import 'package:abc/chart.dart';
import 'package:abc/new_transaction.dart';
import 'package:abc/user_transactions.dart';
import 'package:flutter/rendering.dart';
import './transaction.dart';
import 'package:flutter/material.dart';
import './transaction_list.dart';

void main() {
  runApp(MyApp());
}
//stateful widget
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
// initializes list of transactions recharge and lunch 
class _MyAppState extends State<MyApp> {
  List<Transaction> transactionList = [
    Transaction(
        id: "1", title: "Recharge", amount: 100, dateTime: DateTime.now()),
    Transaction(id: '1', title: "Lunch", amount: 100, dateTime: DateTime.now()),
  ];

//defines  getter method recentTransaction > returns a list of transactions > those with a dateTime 
  List<Transaction> get recentTransaction {
    return transactionList.where((tx) {
        return tx.dateTime.isAfter
        (DateTime.now().subtract(
          Duration(days: 7),
          ),
        );
    }).toList();
  }


//_addTransaction method creates a new transaction object with the given title and amount, assigns it a unique ID based on the current date and time, adds it to the transaction list, and updates the widget state.
  void _addTransaction(String title, double amount) {
    var transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        dateTime: DateTime.now());
    setState(() {
      transactionList.add(transaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    print("Hello");
    showModalBottomSheet(
      context: context,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(primarySwatch: Colors.purple, accentColor: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Personal Expenses"),
          actions: <Widget>[
            IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            Chart(recentTransaction),
            //User_Transaction(),
            TransactionList(transactionList),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add),
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
