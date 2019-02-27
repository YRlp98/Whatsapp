import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          _cameraPreviewWidget()
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget() {

  }
}
