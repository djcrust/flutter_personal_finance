import 'package:flutter/material.dart';
import 'package:my_money_management_app/widget/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/crudcategory.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  String _userUid;
  String _categoryName ;
  String _description ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CrudCategoryMethods  catObj = new CrudCategoryMethods();
  Stream cate;

  Future<String> setUserUid() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userUid = prefs.getString('user_uid');
    setState(() => _userUid = userUid.toString());
  }

  @override
  void initState() {
    setUserUid();
    catObj.getData(_userUid).then((results) {
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
        title: Text('Categories'),
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
      body: _cateList(),
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
              title: Text( selectedDoc == 0 ? 'Add Category' : 'Edit Category'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'The field CATEGORY NAME cannot be empty!';
                      }
                      return null;
                    },
                    onSaved: (input) => _categoryName = input,
                    initialValue: selectedDoc == 0 ? '' : _categoryName,
                    decoration: InputDecoration(
                        hintText: "Category name..."
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    maxLines: 10,
                    onSaved: (input) => _description = input,
                    initialValue: selectedDoc == 0 ? '' : _description,
                    decoration: InputDecoration(
                        hintText: "Description..."
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
                            'name': this._categoryName,
                            'description': this._description,
                            'uid' : _userUid,
                            'created_at' : new DateTime.now()
                          };

                          if (selectedDoc == 0) {
                            catObj.addData(catData).then((result){
                            }).catchError((e){
                              //print(e);
                            });
                          }else {
                            catObj.updateData(selectedDoc,catData).then((result){
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

  Widget _cateList() {
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
                subtitle: Text(snapshot.data.documents[i].data['description'].toString()),
                onTap: (){
                  setState(() {
                    _categoryName = snapshot.data.documents[i].data['name'];
                    _description = snapshot.data.documents[i].data['description'];
                  });
                  _showDialog(context,snapshot.data.documents[i].documentID);
                },
                onLongPress: () {
                  catObj.deleteData(snapshot.data.documents[i].documentID);
                },
              );
            },
          );
        },
      );
    }

}
