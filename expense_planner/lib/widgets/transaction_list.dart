import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty? 
      LayoutBuilder(builder: (ctx,constraints){
        return Column(children: <Widget>[
        Text(
          "No Transactions Added Yet",
          style: Theme.of(context).textTheme.title,
          ),
        SizedBox(height: 10,),
        Container(
          height: constraints.maxHeight * 0.6,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,)
          )
      ],);
      },)    
      : ListView.builder(
        itemBuilder: (ctx, index) {
         return Card(
           elevation: 5,
           margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5
           ),
            child: ListTile(
             title: Text(
             transactions[index].title,


             style: Theme.of(context).textTheme.title,
             ),

             subtitle: Text(
               DateFormat.yMMMd().format(transactions[index].date)
             ),
             
            //  trailing: ,
             leading: CircleAvatar(
               radius: 30,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: FittedBox(
                   child: Text('${transactions[index].amount}')),
               ),
               ),
               
               trailing:MediaQuery.of(context).size.width >460 ? 
                FlatButton.icon(
                  textColor: Theme.of(context).errorColor,
                  onPressed:  (){deleteTx(transactions[index].id);}, 
                  icon: Icon(Icons.delete), 
                  label: Text("Delete"),
                  )
                  : 
                IconButton(
                 icon: Icon(Icons.delete), 
                 color: Theme.of(context).errorColor,
                 onPressed: (){deleteTx(transactions[index].id);}
                 ),
           ),
         );
        },
        itemCount: transactions.length,
      );
  }
}
