// import 'package:expence_app/widgets/new_transaction.dart';
// import 'package:flutter/services.dart';

import 'dart:io';

import 'package:flutter/cupertino.dart';

import './widgets/chart.dart';

import '/widgets/transaction_list.dart';
import 'package:expence_app/widgets/new_transaction.dart';
// import '/widgets/user_transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

void main() {
//   WidgetsFlutterBinding.ensureInitialized();
// SystemChrome.setPreferredOrientations([
//   DeviceOrientation.portraitUp,
//   DeviceOrientation.portraitDown
// ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        // appBarTheme: AppBarTheme(
        //   titleTextStyle:'OpenSans' ,
        // )
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>with WidgetsBindingObserver {
  final List<transaction> _usertransaction = [
    //list of folder
    // transaction(
    //   id: 't1',
    //   title: 'New shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // transaction(
    //   id: 't2',
    //   title: 'new table',
    //   amount: 17.79,
    //   date: DateTime.now(),
    // )
  ];
  bool ShowChart = false;

@override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    
    super.initState();
  }

@override
void didChangeAppLifecycleState(AppLifecycleState state){
print(state);
}

@override
 dispose(){
  WidgetsBinding.instance.removeObserver(this);
  super.dispose();
 }

  List<transaction> get _recentTransaction {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewtransaction(
      String Txtitle, double Txamount, DateTime ChosenDate) {
    //function to add a transaction
    final newTX = transaction(
      id: DateTime.now().toString(),
      title: Txtitle,
      amount: Txamount,
      date: ChosenDate,
    );

    setState(() {
      _usertransaction.add(newTX);
    });
  }

  void StratAddNewTransaction(BuildContext ctx) {
    //starting the proccess
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewtransaction),
          );
        });
  }

  void DeleteTransation(String id) {
    setState(() {
      _usertransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // scafold and app bar emplimentation
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Personal Expenses",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => StratAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text(
              'Personal Expense',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () => StratAddNewTransaction(context),
                  icon: const Icon(Icons.add))
            ],
          );
    final txlistWidget = Container(
      height: (MediaQuery.of(context).size.height -
              56 -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(_usertransaction, DeleteTransation),
    );
    final bodypage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Switch.adaptive(
                    value: ShowChart,
                    onChanged: (val) {
                      setState(() {
                        ShowChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        56 -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransaction),
              ),
            if (!isLandscape) txlistWidget,
            if (isLandscape)
              ShowChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              56 -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTransaction),
                    )
                  : txlistWidget
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodypage,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar as AppBar,
            body: bodypage,
            floatingActionButtonLocation: FloatingActionButtonLocation
                .centerFloat, //floating button emplimentation at th e buttom of the page
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => StratAddNewTransaction(context),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
