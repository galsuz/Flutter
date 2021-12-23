import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'image_store.g.dart';

class ImageStore = _ImageStore with _$ImageStore;

abstract class _ImageStore with Store {

  @observable
  ObservableList<File> images = ObservableList.of([]);

  @action
  Future pickImage(ImageSource type) async {
    try {
      final image = await ImagePicker().pickImage(source: type);
      if (image == null) return;

      final imageTemporary = File(image.path);
      images.add(imageTemporary);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}

