import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_search_model.dart';
import 'package:yakmoya/pill/pill_picture/provider/pill_search_provider.dart';
import 'package:yakmoya/user/view/splash_screen.dart';

class PictureSearchScreen extends ConsumerStatefulWidget {
  const PictureSearchScreen({super.key});

  @override
  _PictureSearchScreenState createState() => _PictureSearchScreenState();
}

class _PictureSearchScreenState extends ConsumerState<PictureSearchScreen> {
  final PillSearchModel testModel = PillSearchModel(
    labelForms: "경질캡슐제",
    labelShapes: "장방형",
    labelColor1: "하양",
    labelColor2: "남색",
    labelPrintFront: "HL PGN 50",
    labelPrintBack: "",
    labelLineFront: "",
    labelLineBack: "",
  );

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(pillSearchStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Picture Search'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => searchImage(),
              child: Text('검색 시작'),
            ),
            const SizedBox(height: 20),
            buildSearchResults(searchState),
          ],
        ),
      ),
    );
  }

  Future<void> searchImage() async {
    ref.read(pillSearchStateNotifierProvider.notifier).searchImage(testModel);
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
        return Text('검색 버튼을 눌러주세요!');
    }
  }
}
