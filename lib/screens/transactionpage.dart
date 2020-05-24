import 'package:flutter/material.dart';
import 'package:my_money_management_app/screens/transactiondatasheet.dart';
import 'package:my_money_management_app/widget/drawer.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        centerTitle: true,
      ),
      body: new Container(

      ),
      drawer: buildDrawer(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => TransactionDatasheet());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}