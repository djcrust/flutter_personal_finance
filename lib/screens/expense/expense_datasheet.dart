import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class ExpenseDatasheet extends StatefulWidget {
  @override
  _ExpenseDatasheetState createState() => _ExpenseDatasheetState();
}

class _ExpenseDatasheetState extends State<ExpenseDatasheet> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("New Expense"),
        elevation: 4.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {

            },
          )
        ],
      ),
      body: _expense_form(),
    );
  }
}


Widget _expense_form() {
  final format_time = DateFormat("dd/MM/yyyy");
  return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
            children: <Widget>[
              DateTimeField(
                autofocus: false,
                format: format_time,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                decoration: InputDecoration(
                  hintText: "Date",
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: Icon(Icons.date_range),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'The field CATEGORY cannot be empty!';
                  }
                  return null;
                },
                //onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  hintText: "Category",
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: Icon(Icons.category),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                keyboardType: TextInputType.number,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'The field AMOUNT cannot be empty!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Amount",
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'The field NOTE cannot be empty!';
                  }
                  return null;
                },
                maxLines: 5,
                //onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  hintText: "Note",
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: Icon(Icons.note),
                ),
              ),
            ],
        ),
      ),
  );
}