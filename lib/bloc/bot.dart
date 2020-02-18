import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skin_care/models/question.dart';
import 'package:skin_care/utils/bot_api.dart';

class Bot extends ChangeNotifier {
  BotApi botApi;
  Bot() {
    botApi = BotApi("username");
  }
  static Input kInput = Input(
    isAnswer: true,
    text: "Hey! \nAm mediCare. How are you up to today ?",
  );
  var receives = BehaviorSubject<Input>.seeded(kInput);
  List<String> symptoms = [];
  List<List<Input>> history = [];

  Future<void> query(String command) async {
    var input = Input(text: command);
    receives.sink.add(input);
    var reply = await botApi.queryApi(command);
    receives.sink.add(reply);
    print("query done");
  }

  void saveConversation(List<Input> _history) {
    history.add(_history);
    receives.sink.add(kInput);
  }

  @override
  dispose() {
    receives.close();
    super.dispose();
  }
}
