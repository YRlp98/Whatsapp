import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController;
  List<CameraDescription> _cameras;

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
        children: <Widget>[_cameraPreviewWidget()],
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return new Text(
        '\nError: No camera detected',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      );
    } else {
      return new Transform.scale(
        scale: 1,
        child: new Center(
          child: AspectRatio(
            aspectRatio: _cameraController.value.aspectRatio,
            child: new CameraPreview(_cameraController),
          ),
        ),
      );
    }
  }
}
