import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class CheckSettings with ChangeNotifier {

  bool isConnected;

  Future isAlreadyConnected() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString('user_email');
    if (userEmail != null) {
      isConnected =  true;
    } else {
      isConnected =  false;
    }
    notifyListeners();

  }

}