// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'signin.dart';
// import 'listofLists.dart';

// class EmailScreen extends StatefulWidget {
//   @override
//   _EmailScreen createState() => _EmailScreen();
// }

// class _EmailScreen extends State<EmailScreen> {
//   final _formKey2 = GlobalKey<FormState>();
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   DatabaseReference dbRef =
//   FirebaseDatabase.instance.reference().child("Users");
//   TextEditingController emailController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: const Text('Email Sign Up'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Form(
//         key: _formKey2,
//         child: Center(
//           child: Column /*or Column*/ (
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.orange, width: 1.0),
//                     ),
//                     hintText: ' New Username',
//                   ),
//                   validator: (username) {
//                     if (username == null || username.isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.orange, width: 1.0),
//                     ),
//                     hintText: 'New Email',
//                   ),
//                   validator: (email) {
//                     if (email == null || email.isEmpty) {
//                       return 'Please enter an email';
//                     }
//                     return null;
//                   },
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.orange, width: 1.0),
//                     ),
//                     hintText: 'New Password',
//                   ),
//                   validator: (password) {
//                     if (password == null || password.isEmpty) {
//                       return 'Please enter a Password';
//                     } else if (password.length < 6) {
//                       return 'Password must be atleast 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//               ),

//               // Submit Button
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: RaisedButton(
//                   onPressed: () {
//                     if (_formKey2.currentState.validate()) {
//                       // If the form is valid, display a Snackbar.
//                       Scaffold.of(context).showSnackBar(
//                           SnackBar(content: Text('Processing Data')));
//                           registerToFb(); // Register to Firebase
//                     }
//                   },
//                   child: Text('Submit'),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void registerToFb() {
//     firebaseAuth
//         .createUserWithEmailAndPassword(
//             email: emailController.text, password: passwordController.text)
//         .then((result) {
//       dbRef.child(result.user.uid).set({
//         "email": emailController.text,
//         "name": nameController.text
//       }).then((res) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => ListScreen(uid: result.user.uid)),
//         );
//       });
//     }).catchError((err) {
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Error"),
//               content: Text(err.message),
//               actions: [
//                 FlatButton(
//                   child: Text("Ok"),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 )
//               ],
//             );
//           });
//     });
//   }
// }

  
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../screens/listofLists.dart';

class EmailSignUp extends StatefulWidget {
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          backgroundColor: Colors.orange,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Enter User Name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter User Name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Enter Email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter an Email Address';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Password';
                    } else if (value.length < 6) {
                      return 'Password must be atleast 6 characters!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: isLoading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        color: Colors.orange,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            registerToFb();
                          }
                        },
                        child: Text('Submit'),
                      ),
              )
            ]))));
  }

  void registerToFb() {
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      dbRef.child(result.user.uid).set({
        "email": emailController.text,
        "name": nameController.text
      }).then((res) {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ListScreen(uid: result.user.uid)),
        );
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}

