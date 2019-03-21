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

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
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
        _showInSnackBar(
            'Camera error ${_cameraController.value.errorDescription}');
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

  void _showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: new Text(
      message,
      textDirection: TextDirection.rtl,
      style: TextStyle(fontFamily: 'Vazir'),
    )));
  }

  void _showCameraException(CameraException e) {
    print('Error : ${e.code}\nError Message : ${e.description}');
    _showInSnackBar('Error Message : ${e.description}');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        child: Center(
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
        padding: EdgeInsets.only(bottom: 20),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: new SizedBox(
                width: screenSize.width,
                height: 60,
                child: new ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _files.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      Map file = _files[index];
                      String type = file['type'];
                      String ImagePath =
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
                                Image.file(File(ImagePath), fit: BoxFit.cover),
                                type == 'video'
                                    ? new Align(
                                        alignment: Alignment.bottomLeft,
                                        child: new Padding(
                                            padding: EdgeInsets.only(
                                                left: 2, bottom: 2),
                                            child: Icon(Icons.camera_alt,
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
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.switch_camera,
                        size: 36, color: Colors.white),
                    onPressed: _cameraSwitchToggle),
                new GestureDetector(
                  onTap: _onTakePictureButtonPressed,
                  onLongPress: _onStartVideoRecording,
                  onLongPressUp: _onStopVideoRecording,
                  child: new Container(
                    width: 65,
                    height: 65,
                    decoration: new BoxDecoration(
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
                new IconButton(
                    icon: new Icon(Icons.flash_off,
                        size: 36, color: Colors.white),
                    onPressed: () {})
              ],
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 16),
              child: new Text('نگه دارید فیلم بگیرید، بزنید تا عکس بگیرید',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
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
      _showInSnackBar('شما قادر به تغییر دوربین نیستید');
    }
  }

  void _onTakePictureButtonPressed() async {
    String filePath = await takePicture();

    setState(() {
      _files.add({'type': 'image', 'path': filePath});
    });

    _showInSnackBar('تصویر در آدرس زیر ذخیره شد \n $filePath');
  }

  Future<String> takePicture() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/whatsapp';
    await Directory(dirPath).create(recursive: true);
    final filePath = '$dirPath/${timestamp()}.jpg';

    try {
      await _cameraController.takePicture(filePath);
    } on CameraException catch (e) {
      print(e);
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _onStartVideoRecording() async {
    if (_cameraController.value.isRecordingVideo) {
      _showInSnackBar('دوربین در حال ضبط است');
      return;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
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

  void _onStopVideoRecording() async {
    if (!_cameraController.value.isRecordingVideo) {
      _showInSnackBar('دوربین در حال ضبط است');
      return;
    }

    try {
      await _cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (tempFilePath == null) {
      _showInSnackBar('فایلی برای متوقف شدن وجود ندارد.');
      return;
    }

    final Directory tempDir = await getTemporaryDirectory();

    String thumb = await Thumbnails.getThumbnail(
        thumbnailFolder: '${tempDir.path}/Pictures/whatsapp',
        // creates the specified path if it doesnt exist
        videoFile: tempFilePath,
        imageType: ThumbFormat.JPEG,
        quality: 60);

    setState(() {
      _files.add({'type': 'video', 'path': tempFilePath, 'thumb': thumb});

      _showInSnackBar('ویدیو در مسیر زیر ذخیره شد \n\n ${tempFilePath}');

      tempFilePath = null;
    });
  }
}
