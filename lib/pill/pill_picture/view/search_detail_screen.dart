import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_detail_model.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';
import 'package:yakmoya/pill/pill_picture/provider/pill_search_provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:yakmoya/user/model/user_pill_model.dart';
import 'package:yakmoya/user/provider/user_me_provider.dart';
import 'package:yakmoya/user/view/splash_screen.dart';

class SearchDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'detail';
  final String id;

  const SearchDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends ConsumerState<SearchDetailScreen> {
  bool isFavorite = false; // 좋아요 상태를 로컬에서 관리
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // ref.read(pillSearchProvider.notifier).getDetail(id: widget.id);
  //   ref.read(pillSearchProvider.notifier).getPillDetail(widget.id);
  //   print('now');
  //   super.initState();
  // }

  @override
  void initState() {
    super.initState();
    // ref.read(pillSearchProvider.notifier).getDetail(id: widget.id);
    ref.read(pillSearchProvider.notifier).getPillDetail(widget.id).then((_) {
      final pillDetail = ref.read(pillSearchProvider).pillDetailModel;
      if (pillDetail != null) {
        final pillsState = ref.read(pillsProvider);
        if (pillsState is AsyncData<List<UserPillModel>>) {
          setState(() {
            isFavorite = pillsState.value.any((pill) => pill.id == pillDetail.id);
          });
        }
      }
    });
  }

  List<String> parseAndSplitText(String text) {
    return text
        .split('.')
        .map((str) => str.trim())
        .where((str) => str.isNotEmpty)
        .toList();
  }

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
    final state = ref.watch(pillSearchProvider);
    final pillsState = ref.watch(pillsProvider);

    List<UserPillModel>? pills;

    if (pillsState is AsyncData<List<UserPillModel>>) {
      pills = pillsState.value;
    }

    if (state.pillDetailModel == null) {
      return Scaffold(
        body: renderLoading(),
      );
    }
    final pillDetail = state.pillDetailModel!; // Non-nullable
    final parsedPillName = parsePillName(pillDetail.name);

    bool isPillFavorite(
        PillDetailModel pillDetail, List<UserPillModel>? pills) {
      if (pills == null) return false;
      return pills.any((pill) => pill.id == pillDetail.id);
    }

    // 조건 확인
    isFavorite = isPillFavorite(pillDetail, pills);
    print(isFavorite);
    void togglePillFavorite() {
      final pillDetail = ref.read(pillSearchProvider).pillDetailModel!;
      final isCurrentlyFavorite = isFavorite;

      setState(() {
        isFavorite = !isFavorite;
      });

      if (isCurrentlyFavorite) {
        ref.read(pillSearchProvider.notifier).deletePill(pillDetail.id.toString());
      } else {
        ref.read(pillSearchProvider.notifier).likesPill(pillDetail.id.toString());
      }
      ref.read(pillsProvider).isRefreshing;
      print(isFavorite);
    }
    // void togglePillFavorite() {
    //   final pillDetail = ref.read(pillSearchProvider).pillDetailModel!;
    //   isFavorite = isPillFavorite(pillDetail, pills);
    //   print(isFavorite);
    //   if (isFavorite) {
    //     print('좋아요 삭제!');
    //     // 좋아요 삭제
    //     ref
    //         .read(pillSearchProvider.notifier)
    //         .deletePill(pillDetail.id.toString());
    //   } else {
    //     print('좋아요 추가!');
    //     // 좋아요 추가
    //     ref
    //         .read(pillSearchProvider.notifier)
    //         .likesPill(pillDetail.id.toString());
    //   }
    //
    //
    //
    //   // 상태 업데이트 (옵셔널)
    //   setState(() {
    //     print('좋아요 반영!');
    //     //
    //     // isFavorite = !isFavorite;
    //     print(isFavorite);
    //     ref.read(pillsProvider);
    //     ref.read(userMeProvider);
    //   });
    // }

    // pillEffect 값을 검사하여 <삭제>일 경우 대체 텍스트를 설정합니다.
    final pillEffectText = pillDetail.pillEffect == "<삭제>"
        ? "해당란은 공백입니다."
        : pillDetail.pillEffect;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '세부정보',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: togglePillFavorite, // 여기에 메서드 연결
              child: SvgPicture.asset(
                isFavorite ? 'assets/img/star2.svg' : 'assets/img/star1.svg',
                width: 40,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              pillDetail.imgLink,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '알약 이름', // 첫 번째 단어만 표시
                    style: TextStyle(
                      fontSize: 20,
                      color: SUB_BLUE_COLOR,
                      fontWeight: FontWeight.w700,
                    ),
                    // overflow: TextOverflow.ellipsis
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        parsedPillName, // 첫 번째 단어만 표시
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: GREY_PRIMARY_COLOR,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // SvgPicture.asset('assets/img/star2.svg',width: 50,),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    thickness: 0.5,
                  ),
                  Text(
                    '주효능 · 효과', // 첫 번째 단어만 표시
                    style: TextStyle(
                      fontSize: 20,
                      color: SUB_BLUE_COLOR,
                      fontWeight: FontWeight.w700,
                    ),
                    // overflow: TextOverflow.ellipsis
                  ),
                  Text(
                    pillEffectText, // 첫 번째 단어만 표시
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: GREY_PRIMARY_COLOR,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[400],
                    thickness: 0.5,
                  ),
                  Text(
                    '언제 복용', // 첫 번째 단어만 표시
                    style: TextStyle(
                      fontSize: 20,
                      color: SUB_BLUE_COLOR,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    pillDetail.pillDetail, // 첫 번째 단어만 표시
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: GREY_COLOR,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[400],
                    thickness: 0.5,
                  ),
                  Text(
                    '알약 주의사항', // 첫 번째 단어만 표시
                    style: TextStyle(
                      fontSize: 20,
                      color: SUB_BLUE_COLOR,
                      fontWeight: FontWeight.w900,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    pillDetail.pillMethod, // 첫 번째 단어만 표시
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: GREY_COLOR,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ),
                  Divider(
                    color: Colors.grey[400],
                    thickness: 0.5,
                  ),
                ],
              ),
            ),
          ],
        ),
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
          padding: EdgeInsets.only(bottom: 32.0),
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
