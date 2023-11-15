import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response.dart';
import 'package:yakmoya/pill/pill_picture/provider/pill_search_provider.dart';
import 'package:yakmoya/user/view/search_widget.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';

class TextSearchScreen extends ConsumerStatefulWidget {
  const TextSearchScreen({super.key});

  @override
  ConsumerState<TextSearchScreen> createState() => _TextSearchScreenState();
}

class _TextSearchScreenState extends ConsumerState<TextSearchScreen> {
  TextEditingController editingController = TextEditingController();
  Timer? debouncer;

  void debounce(VoidCallback callback, {Duration duration = const Duration(milliseconds: 1000)}) {
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

  void searchPill(String query) => debounce(() async {
    String encodedQuery = Uri.encodeComponent(query);
    ref.read(pillSearchStateNotifierProvider.notifier).searchText(encodedQuery);
  });

  @override
  Widget build(BuildContext context) {
    final searchResponse = ref.watch(pillSearchStateNotifierProvider);

    return DefaultLayout(
      title: '이름으로 추가',
      child: Column(
        children: <Widget>[
          buildSearch(),
          SingleChildScrollView(
            child: searchResponse != null
                ? ListView.builder(
              itemCount: searchResponse.results.length, // 검색 결과의 길이
              itemBuilder: (context, index) {
                final pill = searchResponse.results[index]; // 각 항목에 대한 접근
                return buildPill(pill);
              },
            )
                : Center(child: Text('검색 결과가 없습니다.')),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
    text: editingController.text.toString(),
    onChanged: searchPill,
    hintText: '해당 상황에 맞게',
  );

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
