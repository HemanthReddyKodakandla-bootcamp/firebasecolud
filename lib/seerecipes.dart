import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class showRecipeWidget extends StatefulWidget {
  @override
  _showRecipeWidgetState createState() => _showRecipeWidgetState();
}

class _showRecipeWidgetState extends State<showRecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('recipes').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new ListView(
                    children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                      print(document.reference.documentID);
                      return Card(
                        color: Colors.grey,
                        child: new ListTile(
                          title: new Text(document['title']),
                          subtitle: new Text(document['duration']),
                          onTap: (){
                            Firestore.instance.collection("recipes").document(document.reference.documentID).updateData({"title":"name 6"});
                            Firestore.instance.collection("recipes").document(document.reference.documentID).delete();
                          },
                        ),
                      );
                    }).toList(),
                  );
              }
            },
          )),
    );  }
}
