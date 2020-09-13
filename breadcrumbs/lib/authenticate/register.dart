import 'signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'emailScreen.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  String password;
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushReplacement(
                context, PageRouteBuilder( 
                  pageBuilder: (context, animation1, animation2) => SigninScreen(),
                  ),
              );
            },
            child: Text(
              "Already a User?",
            ),
          )
        ],
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Meet Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Roboto')),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Email,
                  text: "Sign up with Email",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailSignUp()),
                    );
                  },
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                    child: Text("Log In Using Email",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.orange)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninScreen()),
                      );
                    }
                )
            )
          ]
        ),
      )  
    );
  }
}
