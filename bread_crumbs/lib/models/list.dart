import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import './users.dart';
import 'package:intl/intl.dart'; // for date format

Future<void> addlist(TextEditingController listName, TextEditingController description) async {

  // Timestamp of newlist
  var now = DateTime.now();

  // Grab current user from firestore
  var firebaseUser = await grabUser();

    // Create list object in firestore
    Firestore.instance
      .collection("users")
      .document(firebaseUser.uid)
      .collection("lists")
      .document(listName.text)
      .setData({
        'listName': listName.text,
        'Description': description.text,
        'Owner': await userName(),
        'Modified': DateFormat().format(now).toString() // This will return date using the default locale
      })
      .then((value) => (listName.text + " added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> removeList(int index) async {

  

  // var firebaseUser = await grabUser();

  // Firestore.instance
  //     .collection("users")
  //     .document(firebaseUser.uid)
  //     .collection('lists')
  //     .document(listName).delete();

}
