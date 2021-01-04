import 'package:bread_crumbs/authenticate/signin.dart';
import 'package:bread_crumbs/init/introScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'listofLists.dart';
import 'favorites.dart';

class SettingScreen extends StatefulWidget {

  final String uid;

  SettingScreen({Key key, this.uid}) : super(key: key);

  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  int _currentIndex = 2;



  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        IntroScreen(),
                  ),
                ));
      Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        SigninScreen(),
                  ),
                );
    } catch (e) {
      print(e); 
    }

  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: new Container(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: _signOut,
          )
        ],
      )),
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
                        ListScreen(uid: widget.uid),
                  ),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        FavoriteScreen(uid: widget.uid),
                  ),
                );
                break;
              case 2:
              // Do nothing since we are in settings
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Grocery Lists',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Favorite Items',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
