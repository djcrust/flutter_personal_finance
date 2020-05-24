import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/homepage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Sign Up'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Container(
        padding:
            EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0, bottom: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                ),
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
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: registerUser,
                child: buildButtonContainer("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonContainer(String labelText) {
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
          labelText,
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user_email', user.email);
        prefs.setString('user_uid', user.uid);

        user.sendEmailVerification();
        Navigator.of(context).pop();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
