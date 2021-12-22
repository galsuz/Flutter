import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'model/message.dart';
import 'package:http/http.dart' as http;
part 'message_store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

abstract class _MessageStore with Store {

  String url = "https://itis-chat-app-ex.herokuapp.com/chat";

  @observable
  ObservableList<Message> messages = ObservableList.of([]);

  @action
  Future<void> getMessage() async {
    var response = await http.get(Uri.parse(url));
    messages = ObservableList.of(messageFromJson(response.body));
  }

  @action
  Future<http.Response> sendMessage(String message) {
    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "author": "Kitty",
        "message": message,
      }),
    );
  }
}