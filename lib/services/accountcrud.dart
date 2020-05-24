import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class CrudAccountMethods {

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getUserUid() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid.toString();
  }

  Future<void> addData (catData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('account').add(catData).catchError((e){
        print(e);
      });
    }
    else {
      print('You need to be logged in');
    }
  }

  getData(userIdData) async{
    print(userIdData);
    return await Firestore.instance.collection('account').snapshots();
  }

  updateData(selectedDoc, newvalues){
    Firestore.instance.collection('account').document(selectedDoc).updateData(newvalues).catchError((e){
      print(e);
    });
  }

  deleteData(selectedDoc){
    Firestore.instance.collection('account').document(selectedDoc).delete().catchError((e){
      print(e);
    });
  }
}