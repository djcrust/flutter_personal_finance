import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionDatasheet extends StatefulWidget {
  @override
  _TransactionDatasheetState createState() => _TransactionDatasheetState();
}

class _TransactionDatasheetState extends State<TransactionDatasheet> {
  String _accountID;
  String _note;
  String _userUid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _accountType = <String>[
    'BNI',
    'BMOI',
    'CAISSE EPARGNE',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: Column(
            children: <Widget>[
              Text(
                'New Transaction',
                style: TextStyle(
                    fontSize: 30, color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("account").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Text("Loading.....");
                    else {
                      List<DropdownMenuItem> accountTypes = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        accountTypes.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.data['name'],
                              style: TextStyle(color: Colors.black54),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DropdownButton(
                            items: accountTypes,
                            onChanged: (accountValue) {
                              setState(() {
                                print(accountValue);
                                _accountID = accountValue;
                              });
                            },
                            value: _accountID,
                            isExpanded: false,
                            hint: new Text(
                              "Choose an Account",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
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
                //onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  hintText: "Amount",
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              SizedBox(
                height: 10,
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
                height: 10,
              ),
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'The field NOTE cannot be empty!';
                  }
                  return null;
                },
                maxLines: 3,
                //onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  hintText: "Note",
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: Icon(Icons.note),
                ),
              ),
              FlatButton(
                onPressed: null,
                child: Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
