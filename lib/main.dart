import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_week4_firebase_app/feedback_bloc.dart';


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
      home: FeedBackWidget(),
    );
  }
}

class FeedBackWidget extends StatefulWidget {
  @override
  _FeedBackWidgetState createState() => _FeedBackWidgetState();
}

class _FeedBackWidgetState extends State<FeedBackWidget> {

  final _feedBackForm = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _feedBackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeedBacks'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _feedBackForm,
              child: Column(
                children: <Widget>[
                  formWidget('Email', 'Enter Email', 'Email cann\'t be empty ', _emailController),
                  formWidget('Name', 'Enter Name', 'Name cann\'t be empty ', _nameController),
                  formWidget('Age', 'Enter Age', 'Age cann\'t be empty ', _ageController),
                  formWidget('FeedBack', 'Enter feedback', 'Feedback cann\'t be empty ', _feedBackController),
                  RaisedButton(
                      onPressed: (){
                    Map<String, dynamic> feedBackData = Map();

                    feedBackData['email'] = _emailController.text;
                    feedBackData['name'] = _nameController.text;
                    feedBackData['age'] = _ageController.text;
                    feedBackData['feedBack'] = _feedBackController.text;

                    sendToFireBase(feedBackData);
                    bloc.addFeedBack.add(feedBackData);
                    setState(() {
                        _emailController.clear();
                        _nameController.clear();
                        _ageController.clear();
                        _feedBackController.clear();
                      });
                      },
                    child: Text('Submit'),
                  ),
                  StreamBuilder(
                    stream: bloc.feedBack,
                      builder: (BuildContext context,AsyncSnapshot<Map<String, dynamic>> snapshot){
                      if(snapshot.hasData){
                        return Card(
                          child: Column(
                            children: <Widget>[
                              Text(snapshot.data['email']),
                              Text(snapshot.data['name']),
                              Text(snapshot.data['age']),
                              Text(snapshot.data['feedBack']),
                            ],
                          ),
                        );
                  }
                      else{
                        return Text('No Data');
                      }
                  })


                ],
              ),
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
    print('feedback${data['email']}');
//    await Firestore.instance.collection('feedback').add(data);
    await Firestore.instance.collection('feedback').add(data).then((DocumentReference snapshot){
      print('feedback data ${snapshot.toString()}');
    });
  }
}

