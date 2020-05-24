import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                child: Icon(
                  Icons.dashboard,
                  size: 100,
                  color: Colors.white,
                ),
                backgroundColor: Colors.redAccent,
                radius: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'My Money Management',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    fontFamily: "Pacifico",
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Version 1.00')
            ],
          )),
    );
  }
}
