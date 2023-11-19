import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    final state = ref.watch(pillSearchDetailProvider(widget.id));
    // 화면 크기를 얻습니다.
    final screenSize = MediaQuery.of(context).size;

    if(state is! SearchResponseModel){
      return Scaffold(body: renderLoading());
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(state.name),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => context.go('/text'),
        ),
      ),
      body: Image.asset(
        state.imgLink.toString(),
        width: screenSize.width * 1, // 화면 너비
        height: screenSize.height * 0.24,
        fit: BoxFit.cover,
      ),
    );
  }
}


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