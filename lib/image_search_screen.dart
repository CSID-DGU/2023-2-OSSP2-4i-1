import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:yakmoya/common/component/custom_appbar.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_search_model.dart';
import 'package:yakmoya/pill/pill_picture/provider/pill_search_provider.dart';
import 'package:yakmoya/pill/pill_picture/view/image_search_results_screen.dart';
import 'package:yakmoya/user/view/splash_screen.dart';

class ImageSearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'image';
  const ImageSearchScreen({Key? key}) : super(key: key);

  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends ConsumerState<ImageSearchScreen> {
  File? _image;
  final picker = ImagePicker();
  List? _outputs;
  PillSearchModel? testModel;

  // 앱이 실행될 때 loadModel 호출
  @override
  void initState() {
    super.initState();
    loadModel1().then((value) {
      setState(() {});
    });
  }

  ///⭐️ (왼쪽에 assets폴더의) 원하는 tflite랑 label을 아래의 loadModel()에 집어넣어주면 됨

  // custom_shape 모델 로드
  loadModel1() async {
    Tflite.close();
    await Tflite.loadModel(
      model: "assets/tflite/model_customShape.tflite",
      labels: "assets/labels/labels_customShape.txt",
    ).then((value) {
      setState(() {
        //_loading = false;
      });
    });
  }

  // drug_shape 모델 로드
  loadModel2() async {
    Tflite.close();
    await Tflite.loadModel(
      model: "assets/tflite/model_drugShape.tflite",
      labels: "assets/labels/labels_drugShape.txt",
    ).then((value) {
      setState(() {
        //_loading = false;
      });
    });
  }

  // line 모델 로드
  loadModel3() async {
    Tflite.close();
    await Tflite.loadModel(
      model: "assets/tflite/model_line.tflite",
      labels: "assets/labels/labels_line.txt",
    ).then((value) {
      setState(() {
        //_loading = false;
      });
    });
  }

  // color 모델 로드
  loadModel4() async {
    Tflite.close();
    await Tflite.loadModel(
      model: "assets/tflite/model_color.tflite",
      labels: "assets/labels/labels_color2.txt",
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

    // custom_shape 예측
    loadModel1();
    var output1 = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 1, // defaults to 5
        threshold: 0, // defaults to 0.1
        asynch: true // defaults to true
        );

    // drug_shape 예측
    loadModel2();
    var output2 = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 1, // defaults to 5
        threshold: 0, // defaults to 0.1
        asynch: true // defaults to true
        );

    // line 예측
    loadModel3();
    var output3 = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 1, // defaults to 5
        threshold: 0, // defaults to 0.1
        asynch: true // defaults to true
        );

    // color 예측
    loadModel4();
    var output4 = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 1, // defaults to 5
        threshold: 0, // defaults to 0.1
        asynch: true // defaults to true
        );

    // 정제가 아니면 분리선이 존재하지 않음
    if (output1![0]['label'] != '정제') {
      output3 = [
        {"index": 2, "label": "X", "confidence": 1}
      ];
    }

    print('Raw output from TFLite: $output1'); // 정제(labelForms)
    print('Raw output from TFLite: $output2'); // 장방형(labelShapes)
    print('Raw output from TFLite: $output3'); // 분리선?
    print('Raw output from TFLite: $output4'); // 하양(color)

    // 예측한 4개의 값 저장
    // 출력 값 예시
    // output1 = [{index: 2, label: 정제, confidence: 0.9749788641929626}]
    // output2 = [{index: 9, label: 타원형, confidence: 0.5708653926849365}]
    // output3 = [{index: 2, label: X, confidence: 0.9957811832427979}]
    // output4 = [{index: 14, label: 하양, confidence: 0.8666980266571045}]

    setState(() {
      // testModel = PillSearchModel(
      //   labelForms: "경질캡슐제",
      //   labelShapes: "장방형",
      //   labelColor1: "하양",
      //   labelColor2: "남색",
      //   labelPrintFront: "HL PGN 50",
      //   labelPrintBack: "",
      //   labelLineFront: "",
      //   labelLineBack: "",
      // );

      _outputs = [output1, output2, output3, output4];
      testModel = PillSearchModel(
        labelForms: _outputs![0][0]['label'].toString(),
        labelShapes: _outputs![1][0]['label'].toString(),
        labelColor1: _outputs![3][0]['label'].toString(),
        labelColor2: _outputs![3][0]['label'].toString(),
      );

    });
    print(_outputs);
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  recycleDialog() {
    // Check if _outputs is not null and has at least one item.
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
                    '제형: ${_outputs![0][0]['label'].toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      background: Paint()..color = Colors.white,
                    ),
                  ),
                  Text(
                    '모양: ${_outputs![1][0]['label'].toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      background: Paint()..color = Colors.white,
                    ),
                  ),
                  Text(
                    '앞면 색상: ${_outputs![3][0]['label'].toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      background: Paint()..color = Colors.white,
                    ),
                  ),
                  Text(
                    '뒷면 색상: ${_outputs![3][0]['label'].toString()}',
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
                  child: new TextButton(
                    child: new Text("Ok"),
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
              content: Column(
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
                  child: new TextButton(
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

  Future<void> searchImage() async {
    print(testModel!.labelColor2);
    ref.read(pillSearchProvider.notifier).searchImage(testModel!);
  }

  Widget buildSearchResults(PillSearchState state) {
    switch (state.pictureSearchStatus) {
      case PictureSearchStatus.loading:
        return SplashScreen();

      case PictureSearchStatus.success:
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.results.length,
          itemBuilder: (context, index) {
            final pill = state.results[index];
            return ListTile(
              title: Text(pill.name), // 알약의 특정 속성 표시
            );
          },
        );
      case PictureSearchStatus.zero:
        return Text('검색 결과가 없습니다!');

      case PictureSearchStatus.error:
        return Text('[에러 발생!!] 잘못된 접근입니다!');

      default: // PictureSearchStatus.initial과 그 외의 상태
        return Text('사진 촬영후에, 검색 버튼을 눌러주세요!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final imageSearchState = ref.watch(pillSearchProvider);
    return DefaultLayout(
      title: '이미지로 찾기',
      backgroundColor: const Color(0xfff4f3f9),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25.0),
            showImage(),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 카메라 촬영 버튼
                FloatingActionButton(
                  heroTag: 'camera',
                  child: Icon(Icons.add_a_photo),
                  tooltip: 'pick Iamge',
                  onPressed: () async {
                    await getImage(ImageSource.camera);
                    recycleDialog();
                  },
                ),

                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  heroTag: 'gallery',
                  child: Icon(Icons.wallpaper),
                  tooltip: 'pick Iamge',
                  onPressed: () async {
                    await getImage(ImageSource.gallery);
                    recycleDialog();
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                await searchImage();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchResultsScreen(),
                  ),
                );
              },
              child: Text('검색 시작'),
            ),
          ],
        ),
      ),
    );
  }

  // 앱이 종료될 때
  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
