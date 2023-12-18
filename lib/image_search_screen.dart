import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:yakmoya/common/component/custom_appbar.dart';
import 'package:yakmoya/common/component/login_next_button.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_search_model.dart';
import 'package:yakmoya/pill/pill_picture/provider/pill_search_provider.dart';
import 'package:yakmoya/pill/pill_picture/view/image_search_results_screen.dart';
import 'package:yakmoya/user/view/flitering_screen.dart';
import 'package:yakmoya/user/view/splash_screen.dart';
import 'package:image/image.dart' as img;

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
  String scannedText = ""; // ocr로 스캔한 문장 저장

  bool isSearch = false;

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
      labels: "assets/labels/labels_color.txt",
    ).then((value) {
      setState(() {
        //_loading = false;
      });
    });
  }

  hsvColor(double h, double s, double v) {
    if (s < 0.2) {
      if (v >= 65) {
        return "하양";
      } else if (v <= 10) {
        return "검정";
      } else {
        return "회색";
      }
    } else {
      if (h < 37) {
        if (s < 0.50) {
          return "갈색";
        } else {
          if (h < 16) {
            return "빨강";
          } else {
            return "주황";
          }
        }
      } else if (h < 64) {
        return "노랑";
      } else if (h < 69) {
        return "연두";
      } else if (h < 144) {
        return "초록";
      } else if (h < 190) {
        return "청록";
      } else if (h < 226) {
        return "파랑";
      } else if (h < 275) {
        return "남색";
      } else if (h < 290) {
        return "보라";
      } else if (h < 320) {
        return "자주";
      } else {
        return "빨강";
      }
    }
  }

  // color 추출
  colorPredict(File image) {
    Image myImage = Image.file(image);
    final img.Image? imagec = img.decodeImage(image.readAsBytesSync());

    Map<String, int> dict = {
      "빨강": 0,
      "갈색": 0,
      "주황": 0,
      "노랑": 0,
      "연두": 0,
      "초록": 0,
      "청록": 0,
      "파랑": 0,
      "남색": 0,
      "보라": 0,
      "자주": 0,
      "하양": 0,
      "검정": 0,
      "회색": 0
    };

    Map<String, int> outdict = {
      "빨강": 0,
      "갈색": 0,
      "주황": 0,
      "노랑": 0,
      "연두": 0,
      "초록": 0,
      "청록": 0,
      "파랑": 0,
      "남색": 0,
      "보라": 0,
      "자주": 0,
      "하양": 0,
      "검정": 0,
      "회색": 0
    };

    double h = 0;
    double s = 0;
    double v = 0;

    for (int i = -1 * min(256, imagec!.width ~/ 2);
        i < min(256, imagec.width ~/ 2);
        i++) {
      for (int j = -1 * min(256, imagec.height ~/ 2);
          j < min(256, imagec.height ~/ 2);
          j++) {
        final int pixelColor = imagec.getPixel(imagec.width ~/ 2 + (i),
            imagec.height ~/ 2 + (j)); // 예: (10, 10) 위치의 픽셀 RGB 값

        final double red = img.getRed(pixelColor).toDouble();
        final double green = img.getGreen(pixelColor).toDouble();
        final double blue = img.getBlue(pixelColor).toDouble();

        double H = 0.0;
        double nmin = min(red, green);
        nmin = min(nmin, blue);

        double nmax = max(red, green);
        nmax = max(nmax, blue);

        double delta = 1; // 색상(H)를 구한다.
        if (nmax != nmin) {
          delta = nmax - nmin;
        }

        if (red == nmax) {
          H = (green - blue) / delta; // 색상이 Yello와 Magenta사이
        } else if (green == nmax) {
          H = 2.0 + (blue - red) / delta; // 색상이 Cyan와 Yello사이
        } else if (blue == nmax) {
          H = 4.0 + (red - green) / delta; // 색상이 Magenta와 Cyan사이
        }
        H *= 60.0;
        if (H < 0.0) {
          H += 360.0;
        }

        double S = (nmax != 0.0) ? (nmax - nmin) / nmax : 0.0;
        double V = nmax / 2.55;

        h = H;
        s = S;
        v = V;

        if (i >= -200 && i <= 200 && j >= -200 && j <= 200) {
          dict[(hsvColor(H, S, V))] = (dict[(hsvColor(H, S, V))]! + 1);
        } else {
          outdict[(hsvColor(H, S, V))] = (outdict[(hsvColor(H, S, V))]! + 1);
        }
      }
    }

    var sortedDict = Map.fromEntries(
        dict.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));

    var sortedoutDict = Map.fromEntries(outdict.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    var ignoreList = [];
    var result = [];

    //print(dict.values);
    //print(outdict.values);

    for (String s in sortedoutDict.keys) {
      //print(s + outdict[s].toString());
      if (sortedoutDict[s]! >= 10000) {
        ignoreList.add(s);
      }
    }
    for (String s in sortedDict.keys) {
      //print(s + dict[s].toString());
      if (sortedDict[s]! >= 10000 && !ignoreList.contains(s)) {
        result.add(s);
      }
    }

    return result;
  }

  /// ############## 여기까지   ##########################################

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource,imageQuality: 99);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
    await classifyImage(File(image!.path)); // 가져온 이미지를 분류 하기 위해 await을 사용
  }

  // 이미지 분류
  Future classifyImage(File image) async {
    // OCR
    final InputImage inputImage = InputImage.fromFilePath(image.path);

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    await textRecognizer.close();

    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + " ";
        // scannedText = scannedText + line.text;
      }
    }

    // 특성 추출
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

    // // color 예측
    // loadModel4();
    var output4 = colorPredict(image);

    // 정제가 아니면 분리선이 존재하지 않음
    if (output1![0]['label'] != '정제') {
      output3 = [
        {"index": 2, "label": "X", "confidence": 1}
      ];
    }
    print('Raw output from TFLite: $output1');
    print('Raw output from TFLite: $output2');
    print('Raw output from TFLite: $output3');
    print('Raw output from TFLite: $output4');

    // 예측한 4개의 값 저장
    // 출력 값 예시
    // output1 = [{index: 2, label: 정제, confidence: 0.9749788641929626}]
    // output2 = [{index: 9, label: 타원형, confidence: 0.5708653926849365}]
    // output3 = [{index: 2, label: X, confidence: 0.9957811832427979}]
    // output4 = [{index: 14, label: 하양, confidence: 0.8666980266571045}]

    setState(() {
      _outputs = [output1, output2, output3, output4];
    });
    print(_outputs);
    print('here');
    print(scannedText.length);
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: _image == null
            ? SvgPicture.asset(
                'assets/img/empty.svg',
              )
            : Image.file(
                File(_image!.path),
                height: 335,
                width: 335,
              ),
      ),
    );
  }

  recycleDialog() {
    // Check if _outputs is not null and has at least one item.
    if (_outputs != null && _outputs!.isNotEmpty) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '검색 결과',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: PRIMARY_RED_COLOR,
                    ),
                  ),
                  Text(
                    '제형: ${_outputs![0][0]['label'].toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '모양: ${_outputs![1][0]['label'].toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '구분선: ${_outputs![2][0]['label'].toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '색상: ${_outputs![3].join(", ").toString() ?? ""}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '식별 문자: $scannedText',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Center(
                  child: new TextButton(
                    child: new Text(
                      "확인",
                      style: TextStyle(
                        color: PRIMARY_BLUE_COLOR,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),

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
          barrierDismissible: true,
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

  // Future<void> searchImage() async {
  //   print(testModel!.labelColor2);
  //   ref.read(pillSearchProvider.notifier).searchImage(testModel!);
  // }

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
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25.0),
            showImage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // 카메라 촬영 버튼
                      SignupEitherButton(
                        text: '사진 촬영',
                        onPressed: () async {
                          isSearch = true;
                          await getImage(ImageSource.camera);
                          recycleDialog();
                        },
                        svgUrl: 'assets/img/camera2.svg',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SignupEitherButton(
                        text: '이미지 업로드',
                        onPressed: () async {
                          isSearch = true;
                          await getImage(ImageSource.gallery);
                          recycleDialog();
                        },
                        svgUrl: 'assets/img/gallery2.svg',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 170,
                  ),
                  LoginNextButton(
                    onPressed: () async {
                      // 색상 데이터를 변수로 분리
                      String color1 = "";
                      String color2 = "";

                      if (_outputs != null &&
                          _outputs!.isNotEmpty &&
                          _outputs![3].length > 0) {
                        color1 = _outputs![3][0];
                        if (_outputs![3].length > 1) {
                          color2 = _outputs![3][1];
                        }
                      }

                      // 필터링 화면으로 이동
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FilteringScreen(
                            form: _outputs![0][0]['label'].toString(),
                            shape: _outputs![1][0]['label'].toString(),
                            color1: color1,
                            color2: color2,
                            text: scannedText,
                            image: _image!,
                          ),
                        ),
                      );
                    },
                    buttonName: '검색 시작',
                    isButtonEnabled: isSearch,
                    color: SUB_BLUE_COLOR,
                  ),
                ],
              ),
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

class SignupEitherButton extends StatelessWidget {
  final String text;
  final String svgUrl;
  final VoidCallback onPressed;

  const SignupEitherButton({
    required this.text,
    required this.onPressed,
    required this.svgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: GREY_BUTTON_COLOR,
        minimumSize: Size(100, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(
            color: GREY_BUTTON_COLOR,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgUrl),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}
