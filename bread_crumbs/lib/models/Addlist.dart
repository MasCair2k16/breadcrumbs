import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';


Future<void> addlist(TextEditingController listName, TextEditingController description) async {

  final databaseReference = Firestore.instance;

  await databaseReference
        .collection("users")
        .add({
            'Description': description.text,
            'listName': listName.text
          })
        .then((value) => (listName.text + " added"))
        .catchError((error) => print("Failed to add user: $error"));

}