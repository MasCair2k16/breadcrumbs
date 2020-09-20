import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import './users.dart';

Future<void> addlist(TextEditingController listName, TextEditingController description) async {
  
  var firebaseUser = await grabUser();


  Firestore.instance.collection("users").document(firebaseUser.uid).collection("lists").document(listName.text).setData(
    {
      'listName': listName.text,
      'Description': description.text, 
      'Owner' : userName().toString()
    }
  ).then((value) => (listName.text + " added"))
      .catchError((error) => print("Failed to add user: $error"));
}

// Future<Map> grabList() async {

//   var firebaseUser = await grabUser();
//   var query  = await databaseReference.collection('users').document(firebaseUser.uid). collection('lists').getDocuments();

// }

