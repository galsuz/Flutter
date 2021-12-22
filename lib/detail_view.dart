// ignore_for_file: prefer_final_fields, prefer_const_constructors, unused_local_variable, unused_field

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'message_store.dart';

class DetailView extends StatefulObserverWidget {
  const DetailView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  MessageStore _messageStore = MessageStore();
  TextEditingController _textEditingController = TextEditingController();

  double defaultPadding = 20;

  @override
  void initState() {
    super.initState();
    _messageStore.getMessage();
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
                itemCount: _messageStore.messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (
                          _messageStore.messages[index].author == "Kitty"
                              ? Alignment.topRight
                              : Alignment.topLeft
                          ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: (
                               Colors.grey.shade200
                              ),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(children: <Widget>[
                          Text(
                            _messageStore.messages[index].message,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            _messageStore.messages[index].author,
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                          ),
                        ]),
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
                                _messageStore.sendMessage(_textEditingController.text);
                                _textEditingController.clear();

                                _messageStore.getMessage();
                                // setState(() {
                                //   _getMessage();
                                // });
                                //initState();
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
