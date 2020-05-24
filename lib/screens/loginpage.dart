import 'homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn = false;
  bool isLoading = false;
  String accountEmail = '';
  bool _isHidden = true;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    //autoLogIn();
    super.initState();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString('user_email');
    if (userEmail != null) {
      setState(() {
        isLoggedIn = true;
        accountEmail = userEmail;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

    //CheckSettings checkSettings = Provider.of<CheckSettings>(context);
    //checkSettings.isAlreadyConnected();

    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
            padding: EdgeInsets.only(
                top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome to My Money Management',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      fontFamily: "Pacifico",
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'The field EMAIL cannot be empty!';
                      }
                      return null;
                    },
                    onSaved: (input) => _email = input,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      prefixIcon: Icon(Icons.email),
                    ),
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'The field PASSWORD cannot be empty!';
                      }
                      return null;
                    },
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 16.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: _toggleVisibility,
                            icon: _isHidden
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility))),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: signIn,
                    child: isLoading
                        != true ? buildButtonContainer()
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account"),
                          SizedBox(width: 0.0),
                          new FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/singup");
                            },
                            child: new Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Created by Alex William"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        setState(() {
          isLoading = true;
        });
        AuthResult result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user_email', user.email);
        prefs.setString('user_uid', user.uid);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        return showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
                ),
              ],
            );
          },
        );
        //print(e.message);
      }
    }
  }

  Widget buildButtonContainer() {
    return Container(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23.0),
          gradient: LinearGradient(colors: [
            Color(0xFFFB415B),
            Color(0xFFEE5623),
          ], begin: Alignment.centerRight, end: Alignment.centerLeft)),
      child: Center(
        child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    );
  }
}
