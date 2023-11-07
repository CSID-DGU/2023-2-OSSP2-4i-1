import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:yakmoya/common/component/custom_appbar.dart';

class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  File? _image;
  final picker = ImagePicker();
  List? _outputs;

  // 앱이 실행될 때 loadModel 호출
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  // 모델과 label.txt를 가져온다.
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model1.tflite",
      labels: "assets/label1.txt",
    ).then((value) {
      setState(() {
        //_loading = false;
      });
    });
  }

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
    await classifyImage(File(image!.path)); // 가져온 이미지를 분류 하기 위해 await을 사용
  }

  // 이미지 분류
  Future classifyImage(File image) async {
    print("asdasddas$image");
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    print('Raw output from TFLite: $output');
    setState(() {
      _outputs = output;
    });
  }

  Widget showImage() {
    double screenWidth = MediaQuery.of(context).size.width;
    // 고정된 높이를 설정하거나 화면의 비율에 따라 설정할 수 있습니다.
    double imageHeight = 200; // 고정된 높이 예시

    return Container(
      color: const Color(0xffd0cece),
      width: screenWidth,
      height: imageHeight, // 고정된 높이로 설정
      child: Center(
        child: _image == null
            ? Text('No image selected.')
            : ClipRect(
          child: Image.file(
            File(_image!.path),
            fit: BoxFit.contain, // 비율 유지
          ),
        ),
      ),
    );
  }




  recycleDialog() {
    if (_outputs != null && _outputs!.isNotEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _outputs![0]['label'].toString().toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      background: Paint()..color = Colors.white,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            );
          });
    } else {
      // Handle the case where _outputs is null or empty.
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "데이터가 없거나 잘못된 이미지 입니다.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    child: new Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            );
          });
    }
  }


  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      appBar: CustomAppBar(),
        backgroundColor: const Color(0xfff4f3f9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text(
            //   'Classify',
            //   style: TextStyle(fontSize: 25, color: const Color(0xff1ea271)),
            // ),
            // SizedBox(height: 25.0
            showImage(),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 카메라 촬영 버튼
                FloatingActionButton(
                  heroTag: "camera",
                  child: Icon(Icons.add_a_photo),
                  tooltip: 'pick Iamge',
                  onPressed: () async {
                    await getImage(ImageSource.camera);
                    recycleDialog();
                  },
                ),
                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  heroTag: "gallery",
                  child: Icon(Icons.wallpaper),
                  tooltip: 'pick Iamge',
                  onPressed: () async {
                    await getImage(ImageSource.gallery);
                    recycleDialog();
                  },
                ),
              ],
            )
          ],
        ));
  }

  // 앱이 종료될 때
  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
