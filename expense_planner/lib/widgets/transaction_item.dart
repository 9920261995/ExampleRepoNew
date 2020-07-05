import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),

        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),

        //  trailing: ,
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(child: Text('${transaction.amount}')),
          ),
        ),

        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                onPressed: () {
                  deleteTx(transaction.id);
                },
                icon: Icon(Icons.delete),
                label: Text("Delete"),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  deleteTx(transaction.id);
                }),
      ),
    );
  }
}
