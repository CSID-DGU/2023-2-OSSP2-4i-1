import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/pill/pill_model.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';
import 'package:yakmoya/pill/pill_picture/provider/pill_search_provider.dart';
import 'package:yakmoya/pill/pill_picture/repository/pill_search_repository.dart';
// 로딩 위젯을 Sliver가 아닌 일반 Padding 위젯으로 변경
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SearchDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'detail';
  final String id;

  const SearchDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends ConsumerState<SearchDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    ref.read(pillSearchProvider.notifier).getDetail(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.read(pillSearchDetailProvider(widget.id));

    // 화면 크기를 얻습니다.
    final screenSize = MediaQuery.of(context).size;

    if (state is! SearchResponseModel) {
      return Scaffold(body: renderLoading());
    }

    // 띄어쓰기를 기준으로 문자열을 분리합니다.
    String firstWord = state.name.split(' ').first;

    String pillDetailWord = state.name.split('.').first;

    return DefaultLayout(
      title: '알약 정보',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            firstWord, // 첫 번째 단어만 표시
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            state.name, // 첫 번째 단어만 표시
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Image.network(
            state.imgLink,
            fit: BoxFit.cover,
          ),
          Text(
            '주효능 · 효과', // 첫 번째 단어만 표시
            style: TextStyle(
              fontSize: 18,
              color: PRIMARY_BLUE_COLOR,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            pillDetailWord, // 첫 번째 단어만 표시
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,),
          ),
          Text(
            '용법 · 용량', // 첫 번째 단어만 표시
            style: TextStyle(
                fontSize: 18,
                color: PRIMARY_BLUE_COLOR,
                fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Widget buildPill(SearchResponseModel pill) => ListTile(
//   title: Text(pill.name),
//   subtitle: Text('약 고유 아이디${pill.id}'),
//   leading: Image.network(
//     pill.imgLink,
//     fit: BoxFit.cover,
//     width: 80,
//     height: 80,
//   ),
//   onTap: () {
//     //goNamed -> pushNamed
//     print('hi');
//     context.pushNamed(SearchDetailScreen.routeName,
//         pathParameters: {'id': pill.id.toString()});
//   },
// );

Widget renderLoading() {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 20.0,
    ),
    child: Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: SkeletonParagraph(
            style: SkeletonParagraphStyle(
              lines: 4,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    ),
  );
}
