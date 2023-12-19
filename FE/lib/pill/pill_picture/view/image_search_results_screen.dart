import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';
import 'package:yakmoya/pill/pill_picture/provider/pill_search_provider.dart';
import 'package:yakmoya/user/view/splash_screen.dart';
import 'package:yakmoya/pill/pill_picture/view/search_detail_screen.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  ConsumerState<SearchResultsScreen> createState() =>
      _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  String parsePillName(String name) {
    final mgIndex = name.indexOf('mg');
    if (mgIndex != -1) {
      // 'mg'가 존재하면 'mg'를 포함하여 그 전까지의 문자열을 반환합니다.
      return name.substring(0, mgIndex + 2);
    } else {
      // 'mg'가 없으면 첫 번째 공백 전까지의 문자열을 반환합니다.
      final firstSpaceIndex = name.indexOf(' ');
      if (firstSpaceIndex != -1) {
        return name.substring(0, firstSpaceIndex);
      }
    }
    // 위 조건에 해당하지 않으면 원본 문자열을 그대로 반환합니다.
    return name;
  }

  @override
  Widget build(BuildContext context) {
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
                return buildPill(pill); // context를 전달합니다.
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
            return buildPill(pill); // context를 전달합니다.
          },
        );
    }
  }

  Widget buildPill(SearchResponseModel pill) => ListTile(
        title: Text(
          parsePillName(pill.name),
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: GREY_PRIMARY_COLOR),
        ),
        // subtitle: Text('약 고유 아이디${pill.id}'),
        leading: Image.network(
          pill.imgLink,
          fit: BoxFit.cover,
          width: 80,
          height: 80,
        ),
        onTap: () {
          //goNamed -> pushNamed
          print('hi');
          context.pushNamed(SearchDetailScreen.routeName,
              pathParameters: {'id': pill.id.toString()});
        },
      );
}

// class TextSearchScreen extends ConsumerStatefulWidget {
//   static String get routeName => 'text';
//   const TextSearchScreen({super.key});
//
//   @override
//   ConsumerState<TextSearchScreen> createState() => _SearchResultsScreenState();
// }
//
//
// class SearchResultsScreen extends ConsumerStatefulWidget {
//   SearchResultsScreen({Key? key}) : super(key: key);
//
//
//   String parsePillName(String name) {
//     final mgIndex = name.indexOf('mg');
//     if (mgIndex != -1) {
//       // 'mg'가 존재하면 'mg'를 포함하여 그 전까지의 문자열을 반환합니다.
//       return name.substring(0, mgIndex + 2);
//     } else {
//       // 'mg'가 없으면 첫 번째 공백 전까지의 문자열을 반환합니다.
//       final firstSpaceIndex = name.indexOf(' ');
//       if (firstSpaceIndex != -1) {
//         return name.substring(0, firstSpaceIndex);
//       }
//     }
//     // 위 조건에 해당하지 않으면 원본 문자열을 그대로 반환합니다.
//     return name;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final imageSearchState = ref.watch(pillSearchProvider);
//     return Scaffold(
//       appBar: AppBar(title: Text('검색 결과')),
//       body: SingleChildScrollView(
//         child: buildSearchResults(imageSearchState),
//       ),
//     );
//   }
//
//   Widget buildSearchResults(PillSearchState state) {
//     switch (state.pictureSearchStatus) {
//       case PictureSearchStatus.loading:
//         return SplashScreen();
//       case PictureSearchStatus.success:
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: state.results.length,
//           itemBuilder: (context, index) {
//             final pill = state.results[index];
//             return ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: state.results.length,
//               itemBuilder: (context, index) {
//                 final pill = state.results[index];
//                 return buildPill(pill); // context를 전달합니다.
//               },
//             );
//           },
//         );
//       case PictureSearchStatus.zero:
//         return Text('검색 결과가 없습니다!');
//
//       case PictureSearchStatus.error:
//         return Text('[에러 발생!!] 잘못된 접근입니다!');
//
//       default: // PictureSearchStatus.initial과 그 외의 상태
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: state.results.length,
//           itemBuilder: (context, index) {
//             final pill = state.results[index];
//             return buildPill(pill); // context를 전달합니다.
//           },
//         );
//     }
//   }
//
//   Widget buildPill(SearchResponseModel pill) => ListTile(
//     title: Text(
//       parsePillName(pill.name),
//       style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w500,
//           color: GREY_PRIMARY_COLOR
//       ),
//     ),
//     // subtitle: Text('약 고유 아이디${pill.id}'),
//     leading: Image.network(
//       pill.imgLink,
//       fit: BoxFit.cover,
//       width: 80,
//       height: 80,
//     ),
//     onTap: () {
//       //goNamed -> pushNamed
//       print('hi');
//       context.pushNamed(SearchDetailScreen.routeName,
//           pathParameters: {'id': pill.id.toString()});
//     },
//   );
// }
