import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_firebase_stream_app/modal.dart';

class RecipeListView extends StatefulWidget {
  @override
  _RecipeListViewState createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  List<Recipe> recipes;

  readFromJson() async {
    print("hghf");
    String json = await rootBundle.loadString('assets/json/recipes.json');
    Iterable jIterbale = jsonDecode(json);
    setState(() {
      recipes = jIterbale.map((f) => Recipe.fromMap(f)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    readFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: recipes != null ? recipes.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: EdgeInsets.all(10.0),
              clipBehavior: Clip.hardEdge,
              elevation: 3.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Image.network(recipes[index].imageUrl,
                            fit: BoxFit.fitWidth),
                      ),
                      Positioned(
                        top: 16.0,
                        right: 16.0,
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.favorite, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                    child: Text(
                      recipes[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black26),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Icon(
                            Icons.timer,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            recipes[index].duration,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                        ]),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.grey,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}