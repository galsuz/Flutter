import 'dart:convert';

List<Message> messageFromJson(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  Message({
    required this.id,
    required this.author,
    required this.message,
  });

  String id;
  String author;
  String message;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    author: json["author"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "message": message,
  };
}
