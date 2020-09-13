import 'package:breadcrumbs/screens/listofLists.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../authenticate/signin.dart';

// Help from: https://medium.com/firebase-tips-tricks/how-to-use-firebase-authentication-in-flutter-50e8b81cb29f

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    // Check if user is already signed in
    FirebaseAuth.instance.currentUser().then((res) {
      print(res);
      if (res != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ListScreen(uid: res.uid)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SigninScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('images/globe.png'),
      ),
    );
  }
}
