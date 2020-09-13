import 'package:flutter/material.dart';
import 'listofLists.dart';
import 'settings.dart';
import '../newObjects/newItem.dart';

class FavoriteScreen extends StatefulWidget {
  
   @override
  _FavoriteScreen createState() => _FavoriteScreen();
  }
  
  class _FavoriteScreen extends State<FavoriteScreen> {
  
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(

      appBar: AppBar(
        title: const Text('Favorite Items'),
        backgroundColor: Colors.orange,
      ),

      body: Center(
        child: Text("Favorites")
      ),

      floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.orange,
      onPressed: () {
        Navigator.pushReplacement(
          context, PageRouteBuilder( 
            pageBuilder: (context, animation1, animation2) => NewItemScreen(),
          ),
        );
      }
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                context, PageRouteBuilder( 
                  pageBuilder: (context, animation1, animation2) => ListScreen(),
                  ),
              );
                break;
              case 1:
                Navigator.pushReplacement(
                context, PageRouteBuilder( 
                  pageBuilder: (context, animation1, animation2) => FavoriteScreen(),
                  ),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                context, PageRouteBuilder( 
                  pageBuilder: (context, animation1, animation2) => SettingScreen(),
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