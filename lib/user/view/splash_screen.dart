import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String get routeName => 'splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentImageIndex = 1;
  late OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // 모든 이미지를 미리 캐시에 저장
      for (int i = 1; i <= 3; i++) {
        precacheImage(AssetImage('assets/img/loading/loading$i.png'), context);
      }

      _changeLoadingImage();
      _showOverlay(context);
    });
  }


  _changeLoadingImage() async {
    await Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _currentImageIndex++;
          // Overlay 업데이트
          overlayEntry.markNeedsBuild();
          _changeLoadingImage();
          if (_currentImageIndex > 3) {
            _currentImageIndex = 1; // 이미지를 다시 시작
          }
        });

        // 재귀 호출로 계속해서 이미지 순환 유지
        print(_currentImageIndex);

      }
    });

  }

  void _showOverlay(BuildContext context) {
    overlayEntry = OverlayEntry(
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) =>
              Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/img/loading/loading$_currentImageIndex.png'),
                    ],
                  ),
                ),
              ),
        )
    );

    Overlay.of(context)?.insert(overlayEntry);
  }

  void removeOverlay() {
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // 실제 화면은 overlay 위에 그려집니다.
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }
}