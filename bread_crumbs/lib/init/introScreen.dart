import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../authenticate/signin.dart';
import '../screens/listofLists.dart';

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
    FirebaseAuth.instance.currentUser().then((user) {

      if (user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ListScreen(uid: user.uid)));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SigninScreen()));
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
