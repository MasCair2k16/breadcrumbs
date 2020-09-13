import 'package:flutter/material.dart';
import 'init/introScreen.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext contextP) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      home: IntroScreen()
    );
  }
}


void main() => runApp(MyApp());