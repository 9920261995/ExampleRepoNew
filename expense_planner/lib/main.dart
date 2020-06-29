import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

import './Model/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

// import 'package:flutter/services.dart';
  
void main() {
    runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        textTheme:ThemeData.light().textTheme.copyWith(
          title: TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 18),
          button: TextStyle(color: Colors.white),
        ) ,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title:TextStyle(
              fontFamily: 'OpenSans',fontSize: 20
              )
              )
          ),
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        accentColor: Colors.amber 
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  final List<Transaction> _userTransactions = [];
  bool showchart = false;

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
          )
          );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount,DateTime dateTime) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: dateTime,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }
  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: (){},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
        );
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });

  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS?CupertinoNavigationBar(
    
      middle: Text("Personal Expenses"),
      trailing: Row(
        
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: (){_startAddNewTransaction(context);} ,
          )
        ],
      ),
    ): AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add,), 
            onPressed: (){_startAddNewTransaction(context);}
            )
        ],
      );

    final txList = Container(
                      height: (mediaQuery.size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
                      child: TransactionList(_userTransactions,_deleteTransaction)
                    );
    final body = SafeArea(
      child:  SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text("Show Chart",style: Theme.of(context).textTheme.title,),
              Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value:  showchart,
                onChanged: (val){
                
                setState(() {
                  showchart = val;
                });
              })
              ],
            ),
            if (!isLandscape) 
            Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height -  mediaQuery.padding.top) * 0.3,
              child: Chart(_recentTransactions)
            ),
            if (!isLandscape) txList,
            if (isLandscape) showchart?
              Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height -  mediaQuery.padding.top) * 0.7,
                child: Chart(_recentTransactions)
              )
              :
              txList
            
          ],
        
        )
      )
    );
    return Platform.isIOS? CupertinoPageScaffold(
      navigationBar: appBar,
      child: body,
    ): Scaffold(
      appBar: appBar,
      body: body,
    
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:Platform.isIOS?Container(): FloatingActionButton(
        onPressed: (){_startAddNewTransaction(context);},
        child: Icon(Icons.add),
        )
    );
  }
}
