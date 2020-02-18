import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:skin_care/models/question.dart';

class BotApi {
  final String username;
  Dio _client;
  BotApi(this.username) {
    _client = Dio(BaseOptions(
      baseUrl: _endPoint,
    ));
  }

  static String _endPoint = "http://10.0.2.2:8088";

  Future<Input> queryApi(String q) async {
    final headers = {
      "Content-type": "application/json",
      // "Accept": "application/json"
    };
    try {
      var resp = await _client.post("", data: {"user": "username", "q": q});
      print(resp.data);
      return Input.fromJson(resp.data);
    } on SocketException {
      return Input.answer(text: "It seams like you internet is down.");
    } catch (e) {
      print(" the error is $e");
      return Input.answer(text: "Something went wrong");
    }
  }
}
