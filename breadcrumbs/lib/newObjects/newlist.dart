import 'package:flutter/material.dart';
import '../screens/listofLists.dart';
import '../screens/settings.dart';
import '../screens/favorites.dart';


class NewListScreen extends StatefulWidget {
  @override
  _NewListScreen createState() => _NewListScreen();
}

class _NewListScreen extends State<NewListScreen> {
  int _currentIndex = 0;
  String newlistName = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(

      appBar: AppBar(
        title: const Text('New Grocery List'),
        backgroundColor: Colors.orange,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column /*or Column*/ (
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                // Text box
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 1.0),
                      ),
                      hintText: 'Enter List Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter a List Name';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      newlistName = text;
                    },
                  ),
                ),

                // Submit Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                      }},
                      child: Text('Submit List Name'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          setState(() {
            _currentIndex = value;

            switch (_currentIndex) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        ListScreen(),
                  ),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        FavoriteScreen(),
                  ),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        SettingScreen(),
                  ),
                );
                break;
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Grocery Lists'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Favorite Items'),
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            title: Text('Settings'),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
