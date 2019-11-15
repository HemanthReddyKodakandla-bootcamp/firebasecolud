import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_stream_app/seerecipes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecipeWidget(),
    );
  }
}

class RecipeWidget extends StatefulWidget {
  @override
  _RecipeWidgetState createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {

  final _feedBackForm = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _ingrediantsController = TextEditingController();

  bool isFav = false;

  List ingredients = [
    {
      "title": "Paneer Makhani",
      "duration": "1hr",
      "ingredients": ["paneer","butter","chilli-powder"],
      "isFav":false,
      "imageUrl": "https://source.unsplash.com/random(266 kB)"
    },
    {
      "title": "Chicken Tikka",
      "duration": "1hr",
      "ingredients": ["boneless chicken","butter","chilli-powder"],
      "isFav":false,
      "imageUrl": "https://source.unsplash.com/random(266 kB)"
    },
    {
      "title": "Paneer Friedrice",
      "duration": "1hr",
      "ingredients": ["Paneer","butter","chilli-powder","rice"],
      "isFav":false,
      "imageUrl": "https://source.unsplash.com/random(266 kB)"
    },
    {
      "title": "Chicken FriedRice",
      "duration": "1hr",
      "ingredients": ["boneless chicken","butter","chilli-powder","rice"],
      "isFav":false,
      "imageUrl": "https://source.unsplash.com/random(266 kB)"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Form(
          key: _feedBackForm,
          child: Column(
            children: <Widget>[
              formWidget('Title', 'Enter title', 'Title cann\'t be empty ', _titleController),
              formWidget('Duration', 'Enter Duration', 'Duration cann\'t be empty ', _durationController),
              formWidget('imageUrl', 'Enter imageUrl', 'url cann\'t be empty ', _imageUrlController),
              formWidget('ingrediants', 'Enter Comma separeted ingrediantas', 'ingrediants cann\'t be empty ', _ingrediantsController),
              RaisedButton(
                onPressed: (){
                  Map<String, dynamic> feedBackData = Map();

                  feedBackData['title'] = _titleController.text;
                  feedBackData['duration'] = _durationController.text;
                  feedBackData['isFav'] = isFav;
                  feedBackData['imageUrl'] = _imageUrlController.text;

                  var ingred = _ingrediantsController.text.split(',');

                  print('int ${ingred}');
                  feedBackData['ingredients'] = ingred;


                sendToFireBase(feedBackData);

                  setState(() {
                    _titleController.clear();
                    _durationController.clear();
                    _ingrediantsController.clear();
                    _imageUrlController.clear();
                  });
                  print(Firestore.instance.collection('recipes').snapshots()
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => showRecipeWidget()));
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget formWidget(String label,String hint,String errMsg,TextEditingController textEditingController){

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: label,

            hintText: hint,
            border: OutlineInputBorder()
        ),
        validator: (value){
          if(value.isEmpty){
            return errMsg;
          }
          return null;
        },
        controller: textEditingController,
      ),
    );
  }
  Future sendToFireBase(Map<String , dynamic> data) async{
    await Firestore.instance.collection('recipes').add(data).then((DocumentReference snapshot){
      print('feedback data ${snapshot.toString()}');
    });
  }
}

