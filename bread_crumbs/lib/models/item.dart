import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './users.dart';
// import 'package:intl/intl.dart'; // for date format

Future<void> additem(TextEditingController itemName, TextEditingController quantity, DocumentSnapshot listData) async {
  
  // Timestamp of newlist
  // var now = DateTime.now();

  // Grab current user from firestore
  var firebaseUser = await grabUser();

  // New item in list
  Firestore.instance
      .collection("users")
      .document(firebaseUser.uid)
      .collection("lists")
      .document(listData['listName'].toString())
      .collection("items")
      .document(itemName.text)
      .setData({
        'itemName': itemName.text,
        'quantity': quantity.text,
        'acquired': 0
  }).then((value) => null);

  // Update timestamp on List
  // Firestore.instance
  //     .collection("users")
  //     .document(firebaseUser.uid)
  //     .collection("lists")
  //     .document(listData['listname'])
  //     .updateData({'Modified': DateFormat().format(now).toString()}).then(
  //         (value) => null);
}
