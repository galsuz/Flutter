import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:homework_app/screen/gallery/photo_detail_view.dart';

import '../../image_store.dart';

class GalleryView extends StatefulObserverWidget {

  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {

  ImageStore _imageStore = ImageStore();

  @override
  void initState() {
    super.initState();
  }

  showAlertDialog(BuildContext context) {

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget addButton = TextButton(
      child: Text("Add photo"),
      onPressed:  () {
        _imageStore.pickImage(ImageSource.gallery);
        Navigator.of(context).pop();
      },
    );
    Widget createButton = TextButton(
      child: Text("Create photo"),
      onPressed:  () {
        _imageStore.pickImage(ImageSource.camera);
        Navigator.of(context).pop();
      },
    );

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text("Add photo"),
      content: Text("Add your cat photo"),
      actions: [
        cancelButton,
        addButton,
        createButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            tooltip: 'Add image',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  showAlertDialog(context));
            },
          ),
        ],
      ),
      backgroundColor: Colors.pink,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsPage(image: _imageStore.images[index])));
                      },
                      child: Hero(
                        tag: 'logo$index',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: FileImage(_imageStore.images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _imageStore.images.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
