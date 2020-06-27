import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import './Model/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import 'package:flutter/services.dart';
  
void main() {
    // WidgetsFlutterBinding.ensureInitialized();
    // SystemChrome.setPreferredOrientations([
    //   // DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   // DeviceOrientation.landscapeRight,
    //   DeviceOrientation.portraitDown
    // ]);
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
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add,), 
            onPressed: (){_startAddNewTransaction(context);}
            )
        ],
      );

    final txList = Container(
                      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
                      child: TransactionList(_userTransactions,_deleteTransaction)
                    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text("Show Chart"),
              Switch(value:  showchart,onChanged: (val){
                setState(() {
                  showchart = val;
                });
              })
              ],
            ),
            if (!isLandscape) 
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height -  MediaQuery.of(context).padding.top) * 0.3,
              child: Chart(_recentTransactions)
            ),
            if (!isLandscape) txList,
            if (isLandscape) showchart?
              Container(
                height: (MediaQuery.of(context).size.height - appBar.preferredSize.height -  MediaQuery.of(context).padding.top) * 0.7,
                child: Chart(_recentTransactions)
              )
              :
              txList
            
          ],
        
        )
        ,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){_startAddNewTransaction(context);},
        child: Icon(Icons.add),
        )
    );
  }
}
