import 'package:bread_crumbs/models/item.dart';
import 'package:bread_crumbs/screens/itemlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewItemScreen extends StatefulWidget {
  final String uid;
  final DocumentSnapshot listData;

  NewItemScreen({Key key, this.uid, this.listData}) : super(key: key);

   @override
  _NewItemScreen createState() => _NewItemScreen();
  }
  
  class _NewItemScreen extends State<NewItemScreen> {

  @override
  Widget build(BuildContext context) {

  final _formKey = GlobalKey<FormState>();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();

    return Scaffold(

      appBar: AppBar(
        title: const Text('New Item'),
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
                  controller: itemNameController,
                  decoration: InputDecoration(
                    labelText: "Item Name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Item Name';
                    }
                    return null;
                  },
                ),
              ),

              // Text box
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: itemQuantityController,
                    decoration: InputDecoration(
                      labelText: "Quantity",
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
                      additem(itemNameController, itemQuantityController, widget.listData).then((_) => 
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                ItemListScreen(uid: widget.uid, listData: widget.listData,),
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