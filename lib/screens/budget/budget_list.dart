import 'package:flutter/material.dart';
import 'package:my_money_management_app/widget/drawer.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Define a budget"),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
    );
  }
}
