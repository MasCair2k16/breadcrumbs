import 'package:flutter/material.dart';
import '../screens/listofLists.dart';
import '../screens/settings.dart';
import '../screens/favorites.dart';

class NewItemScreen extends StatefulWidget {
  
   @override
  _NewItemScreen createState() => _NewItemScreen();
  }
  
  class _NewItemScreen extends State<NewItemScreen> {
  
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {


    final textTheme = Theme.of(context).textTheme;
    return Scaffold(

      appBar: AppBar(
        title: const Text('New Item'),
        backgroundColor: Colors.orange,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column /*or Column*/( 
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1.0),
                  ),
                  hintText: 'Enter Item Name',
                ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1.0),
                  ),
                  hintText: 'Option: Name Brand',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1.0),
                  ),
                  hintText: 'Option: Quantity',
                ),
                ),
              ),

              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1.0),
                  ),
                  hintText: 'Option: Food Type (ex: Dairy, Meat, Veggies, etc)',
                  ),
                ),
              ),

              
            ],
          ),
        ),
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