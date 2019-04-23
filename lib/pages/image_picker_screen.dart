import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ImagePickerScreenState();
}

class ImagePickerScreenState extends State<ImagePickerScreen> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('تصاویر'),
      ),
      body: new Center(
          child: _image == null
              ? new Text('تصویری انتخاب نشده است')
              : new Image.file(_image)),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
}
