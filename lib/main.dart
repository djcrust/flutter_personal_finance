import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'screens/loginpage.dart';
import 'screens/signuppage.dart';
import 'screens/homepage.dart';
import 'screens/about.dart';
import 'screens/categorylist.dart';
import 'services/conneixon_set.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => CheckSettings(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Personal Finance',
      theme: ThemeData(primaryColor: Color(0xFFFB415B), fontFamily: "Ubuntu",
      ),
      home: _handleAuth(),
      routes: <String, WidgetBuilder>{
        '/singup': (BuildContext context) => new SignupPage(),
        '/homepage': (BuildContext context) => new HomePage(),
        '/aboutpage': (BuildContext context) => new AboutPage(),
        '/categorylist': (BuildContext context) => new CategoryPage(),
      },
    );
  }

  Widget _handleAuth(){
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        return (!snapshot.hasData) ?  LoginPage(): HomePage() ;
      },
    );
  }

}
