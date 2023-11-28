

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yakmoya/common/component/normal_appbar.dart';
import 'package:yakmoya/image_search_screen.dart';
import 'package:yakmoya/pill/pill_picture/view/text_search_screen.dart';

import '../../common/const/colors.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(
        title: '약 찾기',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // add this
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 깎기 위함
                  ),
                  height: 90,
                  alignment: Alignment.center, // 텍스트를 컨테이너 중앙에 배치
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "📸 사진을 통해 찾을 수도 있고\n🔍 검색을 통해 찾을수도 있어요!\n",
                      textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
              _buildClickableContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageSearchScreen(),
                    ),
                  );
                },
                title: '이미지로 찾기',
                description: '사진 한번으로 빠르게 알약 정보를 인식해요!',
                svgAssetPath: 'assets/img/camera.svg',
              ),
              _buildClickableContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TextSearchScreen(),
                    ),
                  );
                },
                title: '이름으로 검색하기',
                description:
                '직접 검색하여 알약정보를 알아봐요!',
                svgAssetPath: 'assets/img/text.svg',
              ),
              _buildClickableContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TextSearchScreen(),
                    ),
                  );
                },
                title: '약학정보원에서 검색하기',
                description:
                '직접 검색하여 알약정보를 알아봐요!',
                svgAssetPath: 'assets/img/link.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}



Widget _buildClickableContainer({
  required VoidCallback onTap,
  required String title,
  required String description,
  required String svgAssetPath, // SVG 파일 경로를 위한 새로운 파라미터
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        // 그라데이션 효과 적용
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            BLUE_BLUE_COLOR.withOpacity(0.4), // 연하게
            BLUE_BLUE_COLOR.withOpacity(0.9), //원래의 색상 * 0.8
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  svgAssetPath,
                  width: 35,
                  height: 35,
                ),
              ),
              SizedBox(width: 5),
              Expanded( // 텍스트가 SVG 옆에 오도록 Expanded로 감싸기
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                    color: PRIMARY_BLUE_COLOR,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}


