import 'package:flutter/material.dart';
import 'dart:io';
import 'package:homework_app/helpers/pinch_zoom_image.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.image}) : super(key: key);
  final File image;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          title: const Text('Gallery'),
          backgroundColor: Colors.pink,
        ),
        body: Container(
        padding: EdgeInsets.all(16),
        child: PinchZoom(image: widget.image),
      )
    );
  }
}
