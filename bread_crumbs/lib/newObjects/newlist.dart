import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/listofLists.dart';
import '../screens/settings.dart';
import '../screens/favorites.dart';
import 'package:bread_crumbs/models/list.dart';


class NewListScreen extends StatefulWidget {

  final String uid;

  NewListScreen({Key key, this.uid}) : super(key: key);

  @override
  _NewListScreen createState() => _NewListScreen();
}

class _NewListScreen extends State<NewListScreen> {
  int _currentIndex = 0;
  String newlistName = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController listNameController = TextEditingController();
  TextEditingController listDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(

      appBar: AppBar(
        title: const Text('New Grocery List'),
        backgroundColor: Colors.orange,
      ),

      body: Form(
        key: _formKey,
        child: Center(
          child: Column /*or Column*/ (
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              // Text box
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: listNameController,
                  decoration: InputDecoration(
                    labelText: "Enter List Name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter List Name';
                    }
                    return null;
                  },
                ),
              ),

              // Text box
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: listDescController,
                    decoration: InputDecoration(
                      labelText: "Enter Description",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter a fun description!';
                      }
                      return null;
                    },
                  ),
                ),

              // Submit Button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      addlist(listNameController, listDescController).then((_) => 
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                ListScreen(uid: widget.uid),
                          ),
                        )
                      );
                      
                    }},
                    child: Text('Submit List'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
