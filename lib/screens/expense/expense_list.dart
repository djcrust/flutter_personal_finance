import 'package:flutter/material.dart';
import 'package:my_money_management_app/screens/expense/expense_datasheet.dart';
import 'package:my_money_management_app/widget/drawer.dart';

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Expenses List"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExpenseDatasheet()),);
            },
          )
        ],
      ),
      drawer: buildDrawer(context),
    );
  }
}
