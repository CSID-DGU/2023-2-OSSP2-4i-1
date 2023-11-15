import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/pill/pill_picture/provider/pill_search_provider.dart';
import 'package:yakmoya/user/view/search_widget.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';
import 'package:yakmoya/user/view/splash_screen.dart';

class TextSearchScreen extends ConsumerStatefulWidget {
  const TextSearchScreen({super.key});

  @override
  ConsumerState<TextSearchScreen> createState() => _TextSearchScreenState();
}

class _TextSearchScreenState extends ConsumerState<TextSearchScreen> {
  TextEditingController editingController = TextEditingController();
  Timer? debouncer;

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(milliseconds: 1000)}) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void searchPill(String query) => debounce(
        () async {
          ref.read(pillSearchStateNotifierProvider.notifier).searchText(query);
        },
      );

  @override
  Widget build(BuildContext context) {
    final pillSearchState = ref.watch(pillSearchStateNotifierProvider);
    final searchStatus = pillSearchState.status;
    final searchResponse = pillSearchState.results; // 검색 결과 가져오기

    print(searchStatus);
    // searchResponse 내용을 콘솔에 출력

    return DefaultLayout(
      title: '이름으로 추가',
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                searchPill(value);
              },
              controller: editingController,
              cursorColor: PRIMARY_BLUE_COLOR, // 커서 색상 변경
              decoration: const InputDecoration(
                hintText: "약 이름을 입력해주세요!",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  // 포커스 됐을 때의 테두리 설정
                  borderSide: BorderSide(color: PRIMARY_BLUE_COLOR, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 2.0,
          ),
          SingleChildScrollView(
            child: () {
              switch (searchStatus) {
                case SearchStatus.loading:
                  return const Center(
                    child: SplashScreen(),
                  );

                case SearchStatus.success:
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchResponse.length,
                    itemBuilder: (context, index) {
                      final pill = searchResponse[index];
                      return buildPill(pill);
                    },
                  );

                case SearchStatus.zero:
                  return const Center(
                    child: Text('검색 결과가 없습니다!'),
                  );

                case SearchStatus.error:
                  return const Center(
                    child: Text('[에러 발생!!] 잘못된 접근입니다!'),
                  );

                default: // SearchStatus.initial과 그 외의 상태
                  return const Center(
                    child: Text('원하는 알약을 검색해 주세요!'),
                  );
              }
            }(),
          )
        ],
      ),
    );
  }

  Widget buildPill(SearchResponseModel pill) => ListTile(
        title: Text(pill.name),
        subtitle: Text('약 고유 아이디${pill.id}'),
        leading: Image.network(
          pill.imgLink,
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        ),
        onTap: () {
          // Navigate to detail screen or any other action
        },
      );
}
