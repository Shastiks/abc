import 'package:abc/chartbar.dart';
import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

//"Transaction" objects as a parameter.
class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  //list of maps for grouped transaction of past 7 days
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      //iterate the recentTransaction list, check date and add to the totalSum variable if date matches.
      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime.day == weekDay.day &&
            recentTransaction[i].dateTime.month == weekDay.month &&
            recentTransaction[i].dateTime.year == weekDay.year) {
          totalSum = totalSum + recentTransaction[i].amount;
        }
      }
      //print weekday name, totalsum return keypair day and ammount
      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
    });
  }

  double get totalSpending { //adding the Expenses from the list of maps using fold method
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }


  //print list and returns a `Card` widget containing a `Row` widget. 
  //map list to `ChartBar`
  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((data) {
          return ChartBar(data['day'].toString(), data['amount'] as double,
              (data['amount'] as double) / totalSpending);
        }).toList(),
      ),
    );
  }
}
