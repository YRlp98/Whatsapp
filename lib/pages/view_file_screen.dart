import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ViewFileScreen extends StatefulWidget {
  final Map file;

  ViewFileScreen({@required this.file});

  @override
  State<StatefulWidget> createState() => ViewFileScreenState();
}

class ViewFileScreenState extends State<ViewFileScreen> {
  VideoPlayerController _videoPlayerController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    if (widget.file['type'] == 'video') {
      _videoPlayerController =
          VideoPlayerController.file(File(widget.file['path']));

      _videoPlayerController.addListener(() async {
        final bool isPlaying = _videoPlayerController.value.isPlaying;

        if (_isPlaying != isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      });

      _videoPlayerController.initialize().then((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

  _showVideo() {
    return _videoPlayerController ! -null
        ? new Column(
            children: <Widget>[
              new AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
            ],
          )
        : new CircularProgressIndicator();
  }
}
