import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakmoya/common/component/login_next_button.dart';
import 'package:yakmoya/common/const/tab_item.dart';
import 'package:yakmoya/image_search_screen.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/pill/pill_picture/view/text_search_screen.dart';
import 'package:yakmoya/user/model/user_model.dart';
import 'package:yakmoya/user/model/user_pill_model.dart';
import 'package:yakmoya/user/provider/user_me_provider.dart';
import 'package:yakmoya/user/view/setting_screen.dart';
import 'package:yakmoya/user/view/splash_screen.dart';

import 'alarm_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  final TabController? tabController;

  HomeScreen({this.tabController});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userMeProvider);
    final pillsState = ref.watch(pillsProvider);

    UserModel? user;
    List<UserPillModel>? pills;

    // User 상태 확인
    if (userState is UserModel) {
      user = userState;
    }

    // Pills 상태 확인
    if (pillsState is AsyncData<List<UserPillModel>>) {
      pills = pillsState.value;
    }

    // 로딩 상태 또는 에러 상태일 때 처리
    if (pills == null || user == null) {
      // 여기에 로딩 또는 에러 상태일 때 보여줄 위젯을 추가하세요.
      // 예: return LoadingIndicator(); 또는 return ErrorIndicator();
      return SplashScreen(); // 임시로 로딩 인디케이터 사용
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/img/applogo.png',
              width: 120,
              height: 120,
            ),
            SizedBox(
              width: 150,
            ),
            InkWell(
              child: SvgPicture.asset(
                'assets/img/alarm.svg',
                width: 35,
                height: 35,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlarmScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen()),
                );
              },
              child: SvgPicture.asset(
                'assets/img/setting.svg',
                width: 35,
                height: 35,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          10,
          10,
          10,
          10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '안녕하세요 \n${user?.name ?? "User"}님!',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                  ),
                ),
                SvgPicture.asset('assets/img/usercircle.svg'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Card(
                child: Container(
                  width: 370,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: BLUE_BLUE_COLOR,
                    ),
                    color: BLUE_BLUE_COLOR,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 18,
                            child: Text(
                              '내 약통',
                              style: TextStyle(
                                fontSize: 22,
                                color: PRIMARY_BLUE_COLOR,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            child: Text(
                              '알약을 추가하여 상호작용 여부를 확인해 보세요!',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: buildPillsGridView(pillsState),
            ),
            LoginNextButton(
              onPressed: () async {
                final interactionResult =
                    await ref.read(interactionProvider.future);
                print(interactionResult);
                if (interactionResult.isNotEmpty) {
                  final pillName1 = interactionResult.first.pillName1;
                  final pillName2 = interactionResult.first.pillName2;
                  final clinical_effect =
                      interactionResult.first.clinicalEffect.first;
                  // 상호작용 결과가 있을 경우 처리
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text("상호작용 중복 경고"),
                      content: Column(
                        children: [
                          Text(
                            '${parsePillName(pillName1)}\n${parsePillName(pillName2)}',
                            style: TextStyle(
                              color: PRIMARY_RED_COLOR,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${clinical_effect}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text("확인"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                } else {
                  // 상호작용 결과가 없을 경우 처리
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text("안전 확인"),
                      content: Text("약물 간 상호작용이 발견되지 않았습니다."),
                      actions: <Widget>[
                        TextButton(
                          child: Text("확인"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                }
              },
              buttonName: '검사하기',
              isButtonEnabled: true,
              color: PRIMARY_BLUE_COLOR,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPillsGridView(AsyncValue<List<UserPillModel>> pillsState) {
    return pillsState.when(
      data: (pills) => GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          if (index == 0) {
            return buildAddPill();
          } else {
            final pill = index - 1 < pills.length ? pills[index - 1] : null;
            return pill != null
                ? buildPillItem(pill)
                : buildDefaultPillItem(index);
          }
        },
      ),
      loading: () => SplashScreen(), // 로딩 상태 처리
      error: (error, stack) => Text('Error: $error'), // 에러 상태 처리
    );
  }

  Widget buildAddPill() {
    return Column(
      children: [
        SvgPicture.asset('assets/img/plus2.svg', width: 60, height: 60),
        Text(
          '추가하기',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget buildPillItem(UserPillModel pill) {
    return Column(
      children: [
        Image.network(
          pill.img,
          height: 60,
        ),
        Text(
          pill.name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: PRIMARY_BLUE_COLOR,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget buildDefaultPillItem(int index) {
    return Column(
      children: [
        SvgPicture.asset('assets/img/plus2.svg', width: 60, height: 60),
        Text('알약 $index',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey[500])),
      ],
    );
  }
}
