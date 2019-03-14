import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:whatsapp/pages/view_file_screen.dart';

class CameraScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController;
  List<CameraDescription> _cameras;
  CameraDescription _cameraDescription;
  String tempFilePath;
  List _files = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  initCamera() async {
    _cameras = await availableCameras();
    selectCamera(camera: _cameras[0]);
  }

  selectCamera({CameraDescription camera}) async {
    setState(() {
      _cameraController = CameraController(camera, ResolutionPreset.high);
      _cameraDescription = camera;
    });

    _cameraController.addListener(() {
      if (_cameraController.value.hasError) {
        _showSnackBar(
            'Camera Error: ${_cameraController.value.errorDescription}');
      }
    });

    try {
      await _cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text(
      message,
      textDirection: TextDirection.rtl,
      style: TextStyle(fontFamily: 'Vazir'),
    )));
  }

  void _showCameraException(CameraException e) {
    print("Error: ${e.code}\nError Message: ${e.description}");
    _showSnackBar('Error Message: ${e.description}');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: new Stack(
        children: <Widget>[
          _cameraPreviewWidget(),
          _cameraBottomSection(context)
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new Transform.scale(
        scale: 1 / _cameraController.value.aspectRatio,
        child: new Center(
          child: AspectRatio(
            aspectRatio: _cameraController.value.aspectRatio,
            child: new CameraPreview(_cameraController),
          ),
        ),
      );
    }
  }

  Widget _cameraBottomSection(context) {
    var screenSize = MediaQuery.of(context).size;

    return new Align(
      alignment: Alignment.bottomCenter,
      child: new Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
//            Preview List
            new Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: new SizedBox(
                height: 60,
                width: screenSize.width,
                child: new ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemCount: _files.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map file = _files[index];
                      String type = file['type'];

                      String imagePath =
                          type == 'image' ? file['path'] : file['thumb'];

                      return new GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      new ViewFileScreen(file: file)));
                        },
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: new SizedBox(
                            width: 70,
                            child: new Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                new Image.file(File(imagePath),
                                    fit: BoxFit.cover),
                                type == 'video'
                                    ? new Align(
                                        alignment: Alignment.bottomLeft,
                                        child: new Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2, bottom: 2),
                                            child: new Icon(Icons.camera_alt,
                                                size: 18, color: Colors.white)),
                                      )
                                    : new SizedBox()
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),

//            Camera Buttons
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
//                 Switch Camera Button
                new IconButton(
                    icon: new Icon(
                      Icons.switch_camera,
                      size: 36,
                      color: Colors.white,
                    ),
                    onPressed: _cameraSwitchToggle),

//                Capture and Record Button
                new GestureDetector(
                  onTap: _onTakePictureButtonPressed,
                  onLongPress: _onStartRecordingVideo,
                  onLongPressUp: _onStopRecordingVideo,
                  child: new Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: new Border.all(
                            width: 4,
                            color: _cameraController != null &&
                                    _cameraController.value.isRecordingVideo
                                ? Colors.redAccent
                                : Colors.white),
                        shape: BoxShape.circle),
                  ),
                ),

//                Flash Button
                new IconButton(
                    icon: new Icon(
                      Icons.flash_off,
                      size: 36,
                      color: Colors.white,
                    ),
                    onPressed: () {})
              ],
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 16),
              child: new Text(
                'Hold to start recording the video',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _cameraSwitchToggle() {
    if (_cameras.length >= 2) {
      selectCamera(
          camera:
              _cameraDescription == _cameras[0] ? _cameras[1] : _cameras[0]);
    } else {
      _showSnackBar('Error: You can not change the camera');
    }
  }

  void _onTakePictureButtonPressed() async {
    String filePath = await takePicture();

    setState(() {
      _files.add({'type': 'image', 'path': filePath});
    });

    _showSnackBar('Picture saved in:\n$filePath');
  }

  Future<String> takePicture() async {
    final Directory extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir.path}/Pictures/whatsapp';
    await Directory(dirPath).create(recursive: true);
    final filePath = '$dirPath/${timestamp()}.jpg';

    try {
      await _cameraController.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _onStartRecordingVideo() async {
    if (_cameraController.value.isRecordingVideo) {
      _showSnackBar('Camera is already recording video');
      return;
    }

    final Directory extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir.path}/Movies/whatsapp';
    await Directory(dirPath).create(recursive: true);
    final filePath = '$dirPath/${timestamp()}.mp4';

    try {
      await _cameraController.startVideoRecording(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    setState(() {
      tempFilePath = filePath;
    });
  }

  void _onStopRecordingVideo() async {
    if (!_cameraController.value.isRecordingVideo) {
      _showSnackBar('Camera is not recording');
      return;
    }

    try {
      await _cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (tempFilePath == null) {
      _showSnackBar('There is no file to save the video');
      return;
    }

    final Directory tempDir = await getTemporaryDirectory();

    String thumb = await Thumbnails.getThumbnail(
        thumbnailFolder: '${tempDir.path}/Pictures/whatsapp',
        videoFile: 'tempFilePath',
        imageType: ThumbFormat.JPEG,
        quality: 60);

    setState(() {
      _files.add({'type': 'video', 'path': tempFilePath, 'thumb': thumb});

      _showSnackBar('Videos saved in:\n${tempFilePath}');

      tempFilePath = null;
    });
  }
}
