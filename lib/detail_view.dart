// ignore_for_file: prefer_final_fields, prefer_const_constructors, unused_local_variable, unused_field

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'chat_message.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  List<ChatMessage> _messages = [
    ChatMessage(messageContent: "Hello!", messageType: "receiver"),
    ChatMessage(messageContent: "Hello?", messageType: "sender"),
  ];

  TextEditingController _textEditingController = TextEditingController();
  double defaultPadding = 20;

  void _addToList(ChatMessage message) {
    setState(() {
      _messages.add(message);
    });
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(),
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/cat.jpg"),
            ),
            SizedBox(width: defaultPadding * 0.75),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title),
                Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (_messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: (_messages[index].messageType == "receiver"
                              ? Colors.grey.shade200
                              : Colors.pink[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          _messages[index].messageContent,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Icon(
                      Icons.mic,
                      color: Colors.pink,
                    ),
                    SizedBox(width: defaultPadding),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 0.75),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: defaultPadding / 4,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _textEditingController,
                                cursorColor: Colors.pink,
                                decoration: InputDecoration(
                                  hintText: "Enter your message",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.send,
                                color: Colors.grey[700],
                              ),
                              onTap: () {
                                ChatMessage message = ChatMessage(
                                    messageContent: _textEditingController.text,
                                    messageType: "sender");
                                _addToList(message);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
