import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ImagePickerScreenState();
}

class ImagePickerScreenState extends State<ImagePickerScreen> {
  Future<File> _imageFile;
  bool isVideo = true;

  VideoPlayerController _videoPlayerController;
  VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      setState(() {});
    };
  }

  @override
  void dispose() {
    if (_videoPlayerController != null) {
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('تصاویر'),
        ),
        body: new Center(child: isVideo ? _previewVideo() : _previewImage()),
        floatingActionButton: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImagePressed(ImageSource.gallery);
              },
              child: new Icon(Icons.photo_library),
            ),
            new SizedBox(height: 16),
            new FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImagePressed(ImageSource.camera);
              },
              child: new Icon(Icons.camera_alt),
            ),
            new SizedBox(height: 16),
            new FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImagePressed(ImageSource.gallery);
              },
              child: new Icon(Icons.video_library),
            ),
            new SizedBox(height: 16),
            new FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImagePressed(ImageSource.camera);
              },
              child: new Icon(Icons.videocam),
            ),
          ],
        ));
  }

//  void getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.camera);
//
//    setState(() {
//      _image = image;
//    });
//  }

  void _onImagePressed(ImageSource source) {
    if (_videoPlayerController != null) {
      _videoPlayerController.setVolume(0);
      _videoPlayerController.removeListener(_listener);
    }

    if (isVideo) {
      ImagePicker.pickVideo(source: source).then((File file) {
        if (file != null) {
          _videoPlayerController = VideoPlayerController.file(file)
            ..addListener(_listener)
            ..setVolume(1)
            ..initialize()
            ..setLooping(true)
            ..play();
        }
      });
    } else {
      _imageFile = ImagePicker.pickImage(source: source);
    }
    if (mounted) setState(() {});
  }

  _previewVideo() {
    if (_videoPlayerController == null) {
      return new Text('ویدیویی انتخاب نشده است');
    } else if (_videoPlayerController.value.initialized) {
      return AspectRatio(
        aspectRatio: 1,
        child: VideoPlayer(_videoPlayerController),
      );
    } else {
      return new Text('مشکل در بارگذاری ویدیو');
    }
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(snapshot.data);
        } else if (snapshot.error != null) {
          return new Text('خطا هنگام بارگذاری تصویر',
              textAlign: TextAlign.center);
        } else {
          return new Text(
            'تصویری انتخاب نشده است',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}
