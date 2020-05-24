import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_money_management_app/screens/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

 Widget buildDrawer(context) {

   return Drawer(
     child: ListView(
       children: <Widget>[
         UserAccountsDrawerHeader(
           accountName: Text("Alex WILLIAM"),
           accountEmail: Text("djcrust@gmail.com"),
           currentAccountPicture: GestureDetector(
             child: CircleAvatar(
               backgroundColor: Colors.grey,
               child: Icon(Icons.person, color: Colors.white),
             ),
           ),
         ),
         InkWell(
           onTap: () {
             Navigator.of(context).pop();
           },
           child: ListTile(
             title: Text('Settings'),
             leading: Icon(Icons.settings),
           ),
         ),
         InkWell(
           onTap: () {
             Navigator.of(context).pop();
             Navigator.pushNamed(context, "/aboutpage");
           },
           child: ListTile(
             title: Text('About'),
             leading: Icon(Icons.help),
           ),
         ),
         InkWell(
           onTap: () async {
             await FirebaseAuth.instance.signOut();
             final SharedPreferences prefs =
             await SharedPreferences.getInstance();
             prefs.setString('user_email', null);
             prefs.setString('user_uid', null);
             Navigator.pushReplacement(context,
                 MaterialPageRoute(builder: (context) => LoginPage()));
           },
           child: ListTile(
             title: Text('Logout'),
             leading: Icon(Icons.exit_to_app),
           ),
         ),
       ],
     ),
   );

 }