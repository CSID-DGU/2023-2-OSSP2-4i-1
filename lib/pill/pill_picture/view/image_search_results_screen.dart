import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';
import 'package:yakmoya/pill/pill_picture/provider/pill_search_provider.dart';
import 'package:yakmoya/user/view/splash_screen.dart';
import 'package:yakmoya/pill/pill_picture/view/search_detail_screen.dart';

class SearchResultsScreen extends ConsumerWidget {
  SearchResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageSearchState = ref.watch(pillSearchProvider);
    return Scaffold(
      appBar: AppBar(title: Text('검색 결과')),
      body: SingleChildScrollView(
        child: buildSearchResults(imageSearchState),
      ),
    );
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
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                final pill = state.results[index];
                return buildPill(context, pill); // context를 전달합니다.
              },
            );
          },
        );
      case PictureSearchStatus.zero:
        return Text('검색 결과가 없습니다!');

      case PictureSearchStatus.error:
        return Text('[에러 발생!!] 잘못된 접근입니다!');

      default: // PictureSearchStatus.initial과 그 외의 상태
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.results.length,
          itemBuilder: (context, index) {
            final pill = state.results[index];
            return buildPill(context, pill); // context를 전달합니다.
          },
        );
    }
  }

  Widget buildPill(BuildContext context, SearchResponseModel pill) => ListTile(
        title: Text(pill.name),
        subtitle: Text('약 고유 아이디: ${pill.id}'),
        leading: Image.network(
          pill.imgLink,
          fit: BoxFit.cover,
          width: 80,
          height: 80,
        ),
        onTap: () {
          // Flutter의 Navigator를 사용하여 상세 화면으로 이동합니다.
          Navigator.pushNamed(context, SearchDetailScreen.routeName,
              arguments: {'id': pill.id.toString()});
        },
      );
}
