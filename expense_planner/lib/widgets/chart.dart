import 'package:flutter/material.dart';
import '../Model/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions); 

  // List <Map<String,Object>> get groupedTransactionValues{
  //   return List.generate(7, (index){
  //     final weekDay = DateTime.now().subtract(Duration(days:index),);
  //     double totalSum;
  //     for(var i = 0;i < recentTransactions.length; i++){
  //       if(recentTransactions[i].date.day == weekDay.day)

  //     } 1


  //     return{
  //       'day':DateFormat.E(weekDay)
  //       'amount':9.99
  //     };
  //   });
  // }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          // C
        ],
      ),
      
    );
  }
}