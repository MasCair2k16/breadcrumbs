import 'package:bread_crumbs/newObjects/newItem.dart';
import 'package:flutter/material.dart';
import 'listofLists.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemListScreen extends StatefulWidget {
  final String uid;
  final DocumentSnapshot listData;

  ItemListScreen({Key key, this.uid, this.listData}) : super(key: key);

  @override
  _ItemListScreen createState() => _ItemListScreen();
}

class _ItemListScreen extends State<ItemListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.listData['listName']),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            // Add users to list
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
            // Add users to list
            IconButton(
              icon: Icon(
                Icons.person_add,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                return await Future.delayed(Duration(seconds: 3));
              },
              child: StreamBuilder<QuerySnapshot>(
                // Build item list
                stream: Firestore.instance
                    .collection('users')
                    .document(widget.uid)
                    .collection('lists')
                    .document(widget.listData['listName'])
                    .collection('items')
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            // data[] holds info
                            DocumentSnapshot itemData =
                                snapshot.data.documents[index];

                            // Item Reference
                            DocumentReference docRef = Firestore.instance
                                .collection('users')
                                .document(widget.uid)
                                .collection('lists')
                                .document(widget.listData['listName']) // name of List
                                .collection('items')
                                .document();
                            return Dismissible(
                              // Dismissed function
                              key: UniqueKey(),
                              onDismissed: (DismissDirection direction) async {
                                // Dispose item from list
                                await Firestore.instance.runTransaction(
                                  (transaction) async {
                                    await transaction.delete(docRef);
                                    await transaction.delete(snapshot
                                        .data.documents[index].reference);
                                  },
                                  // Display Snackbar once list is deleted
                                ).then((index) => Scaffold.of(context)
                                    .showSnackBar(new SnackBar(
                                        content: new Text("Iteam Deleted"))));
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
                                          builder: (context) =>
                                              ItemListScreen(uid: widget.uid)),
                                    );
                                  },
                                  child: Center(
                                    child: new Container(
                                      padding: new EdgeInsets.all(32.0),
                                      child: new Column(
                                        children: <Widget>[
                                          new Text(itemData['itemName']),
                                          new Text(itemData['quantity'])
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
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        NewItemScreen(uid: widget.uid, listData: widget.listData),
                  ),
                );
              },
            )));
  }
}
