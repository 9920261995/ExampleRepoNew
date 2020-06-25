import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime date ;
  void presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate:DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      else{
        setState(() {
           date = pickedDate;
        });
         
      }
    }).catchError((){});
  }


  void submitData() {
    if (amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredTitle == null || enteredAmount <= 0 || enteredAmount == null || date == null){
      return;
    }

    widget.addTx(

      enteredTitle,
      enteredAmount,
      date,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted:(_) => submitData()
             
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted:(_) => submitData()
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(child: 
                    Text(date!=null ? "Picked Date : ${DateFormat.yMd().format(date)}": "No Date Chosen!")
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: presentDatePicker, 
                    child: Text("Choose date",style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),)
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('Add Transaction'),
              textColor: Theme.of(context).textTheme.button.color,
              onPressed:submitData
            ),
            
          ],
        ),
      ),
    );
  }
}
