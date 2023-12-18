import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras!.isNotEmpty) {
        initCamera(cameras!.first);
      }
    }).catchError((e) {
      print('카메라를 사용할 수 없습니다: $e');
    });
  }

  void initCamera(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high, // 고화질 설정
    );

    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<void> takePicture() async {
    if (!controller!.value.isInitialized) {
      print('카메라가 준비되지 않았습니다.');
      return;
    }

    if (controller!.value.isTakingPicture) {
      // 이미 사진을 촬영 중인 경우
      return;
    }

    try {
      final XFile file = await controller!.takePicture();
      setState(() {
        imageFile = file;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: Text('앱 내부 카메라')),
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(controller!),
          ),
          imageFile == null
              ? Container()
              : Image.file(File(imageFile!.path)),
          FloatingActionButton(
            child: Icon(Icons.camera),
            onPressed: takePicture,
          ),
        ],
      ),
    );
  }
}
