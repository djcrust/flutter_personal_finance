import 'package:flutter/material.dart';
import 'package:my_money_management_app/widget/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/accountcrud.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  String _userUid;
  String _accountName ;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CrudAccountMethods  catAccount = new CrudAccountMethods();
  Stream cate;

  // ignore: missing_return
  Future<String> setUserUid() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userUid = prefs.getString('user_uid');
    setState(() => _userUid = userUid.toString());
  }

  @override
  void initState() {
    setUserUid();
    catAccount.getData(_userUid).then((results) {
      setState(() {
        cate = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Account List'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showDialog(context,0);
            },
          )
        ],
      ),
      body: _accountList(),
      drawer: buildDrawer(context),
    );
  }

  Future<bool> _showDialog(BuildContext context, selectedDoc) async {

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: AlertDialog(
              title: Text( selectedDoc == 0 ? 'Add Account' : 'Edit Account'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'The field ACCOUNT NAME cannot be empty!';
                      }
                      return null;
                    },
                    onSaved: (input) => _accountName = input,
                    initialValue: selectedDoc == 0 ? '' : _accountName,
                    decoration: InputDecoration(
                        hintText: "Account name..."
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Save'),
                      onPressed: () {
                        final formState = _formKey.currentState;
                        if (formState.validate()) {
                          formState.save();
                          Navigator.of(context).pop();
                          Map<String, dynamic> catData = {
                            'name': this._accountName,
                            'uid' : _userUid,
                            'created_at' : new DateTime.now()
                          };

                          if (selectedDoc == 0) {
                            catAccount.addData(catData).then((result){
                            }).catchError((e){
                              //print(e);
                            });
                          }else {
                            catAccount.updateData(selectedDoc,catData).then((result){
                            }).catchError((e){
                              //print(e);
                            });
                          }
                        }
                      },
                      color: Colors.green,
                    ),
                    SizedBox(width: 10,),
                    RaisedButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.grey[400],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _accountList() {
    return StreamBuilder(
      stream: cate,
      builder: (context, snapshot){
        if(snapshot.data == null) return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          padding: EdgeInsets.all(5.0),
          itemBuilder: (context, i) {
            return new ListTile(
              title: Text(snapshot.data.documents[i].data['name']),
              onTap: (){
                setState(() {
                  _accountName = snapshot.data.documents[i].data['name'];
                });
                _showDialog(context,snapshot.data.documents[i].documentID);
              },
              onLongPress: () {
                catAccount.deleteData(snapshot.data.documents[i].documentID);
              },
            );
          },
        );
      },
    );
  }

}
