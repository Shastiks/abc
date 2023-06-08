import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
 //state class with text controllers 
 //method to validate and add a transaction 
 //pop screen
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmitPressed(){

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount < 0){
      return;
    }

    widget.addTx(titleController.text,double.parse(amountController.text));

    Navigator.of(context).pop();
  }

  @override
  //Card widget-->Container-->Column that has-->TextField and ElevatedButton 
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => onSubmitPressed(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => onSubmitPressed(),
            ),
            ElevatedButton(
              onPressed: onSubmitPressed,
              child: Text("Add Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
