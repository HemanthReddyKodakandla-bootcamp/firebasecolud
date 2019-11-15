import 'dart:async';

class FeedBackBloc{

  StreamController<Map<String, dynamic>> streamController = StreamController();

  Sink get addFeedBack => streamController.sink;

  Stream<Map<String, dynamic>> get feedBack => streamController.stream;

  dispose(){
    streamController.close();
  }
}

final bloc = FeedBackBloc();