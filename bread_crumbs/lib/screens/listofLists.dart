import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'favorites.dart';
import 'settings.dart';
import '../newObjects/newlist.dart';
import 'itemlist.dart';

class ListScreen extends StatefulWidget {
  final String uid;

  ListScreen({Key key, this.uid}) : super(key: key);

  @override
  _ListScreen createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return await Future.delayed(Duration(seconds: 3));
        },
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('users')
                .document(widget.uid)
                .collection('lists')
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {

                    // data[] holds info
                    DocumentSnapshot listData = snapshot.data.documents[index];
                   
                    DocumentReference docRef = Firestore.instance
                        .collection('users')
                        .document(widget.uid)
                        .collection('lists')
                        .document();
                    return Dismissible(
                      // Dismissed function
                      key: UniqueKey(),
                      onDismissed: (DismissDirection direction) async {

                        // Dispose element from list
                        await Firestore.instance.runTransaction(
                          (transaction) async {
                            await transaction.delete(docRef);
                            await transaction.delete(snapshot.data.documents[index].reference);
                          },
                          // Display Snackbar once list is deleted
                        ).then((index) => Scaffold.of(context)
                          .showSnackBar(new SnackBar( content: new Text("List Deleted")))
                         );

                      },
                      secondaryBackground: Container(
                        child: Center(
                          child: Text('Delete',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.start),
                        ),
                        color: Colors.red,
                      ),
                      background: Container(),

                      // Color drops when touched
                      child: Card(
                        child: InkWell(
                          splashColor: Colors.black.withAlpha(30),

                          // Card clicked
                          onTap: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemListScreen(uid: widget.uid, listData: listData),
                            ));
                          },
                          child: Center(
                            child: new Container(
                              padding: new EdgeInsets.all(32.0),
                              child: new Column(
                                children: <Widget>[
                                  new Text(listData['listName']),
                                  new Text(listData['Description'])
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                    );
                  },
                );
              },
            ),
          ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.orange,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewListScreen(uid: widget.uid)),
            );
          }),

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
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        SettingScreen(uid: widget.uid),
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
