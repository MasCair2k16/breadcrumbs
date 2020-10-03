import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Create User
Future<void> adduser(
    TextEditingController name, TextEditingController email, String uid) async {
  Firestore.instance
      .collection("users")
      .document(uid)
      .setData({
        'name': name.text,
        'email': email.text,
      })
      .then((value) => (name.text + " added"))
      .catchError((error) => print("Failed to add user: $error"));
}

// Grab users firestore identifiction (email, id, etc)
Future<FirebaseUser> grabUser() async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  return firebaseUser;
}

// Grab users username
Future<String> userName() async {
  FirebaseUser user = await grabUser();
  // You can access its data using variable.data['FEILD_NAME']
  DocumentSnapshot variable = await Firestore.instance.collection('users').document(user.uid).get();
  String name = variable.data['name'];
  return name;
}
