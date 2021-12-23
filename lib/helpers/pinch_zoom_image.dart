import 'package:flutter/material.dart';
import 'dart:io';

class PinchZoom extends StatefulWidget {
  const PinchZoom({Key? key, required this.image}) : super(key: key);
  final File image;

  @override
  _PinchZoomState createState() => _PinchZoomState();
}

class _PinchZoomState extends State<PinchZoom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        clipBehavior: Clip.none,
        panEnabled: false,
        minScale: 1,
        maxScale: 4,
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: FileImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
