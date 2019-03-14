import 'dart:io';

import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'package:whatsapp/models/chat_model.dart';

class ViewFileScreen extends StatefulWidget {
  final Map file;

  ViewFileScreen({@required this.file});

  @override
  State<StatefulWidget> createState() => ViewFileScreenState();
}

class ViewFileScreenState extends State<ViewFileScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Scaffold(
            backgroundColor: Colors.black87,
            body: new Center(
                child: widget.file['type'] == 'image'
                    ? _showImage()
                    : _showVideo())));
  }

  _showImage() {
    return new Image.file(File(widget.file['path']), fit: BoxFit.cover);
  }

  _showVideo() {}
}
