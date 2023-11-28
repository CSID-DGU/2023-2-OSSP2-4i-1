import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakmoya/common/component/login_next_button.dart';
import 'package:yakmoya/common/const/tab_item.dart';
import 'package:yakmoya/image_search_screen.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/pill/pill_picture/view/text_search_screen.dart';
import 'package:yakmoya/user/model/user_model.dart';
import 'package:yakmoya/user/provider/user_me_provider.dart';
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
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userMeProvider);
    UserModel? user;
    if (userState is UserModel) {
      user = userState; // UserModel로 캐스팅
    }
    // user 또는 userPointState가 로딩 중일 때 로딩 인디케이터를 표시
    if (user == null) {
      print('로딩중...');
      return const SplashScreen();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              'assets/img/homelogo.svg',
            ),
            InkWell(
              child: SvgPicture.asset(
                'assets/img/alarm.svg',
                width: 40,
                height: 40,
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
              width: 30,
            ),
            SvgPicture.asset(
              'assets/img/setting.svg',
              width: 40,
              height: 40,
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
            Text(
              '안녕하세요.\n${user.name}님',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 26,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
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
                              fontSize: 18,
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
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ), // GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15), // 모서리를 원형으로 깎음
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: GridView.builder(
                          shrinkWrap: true, // GridView를 Column 내부에 넣을 때 필요
                          physics: NeverScrollableScrollPhysics(), // 스크롤 동작 비활성화
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // 한 줄에 4개의 아이템
                            childAspectRatio: 1, // 아이템의 가로세로 비율
                            crossAxisSpacing: 10, // 수평 간격
                            mainAxisSpacing: 10, // 수직 간격
                          ),
                          itemCount: 8, // 총 8개의 아이템
                          itemBuilder: (context, index) {
                            // 첫 번째 아이템인 경우
                            if (index == 0) {
                              return GestureDetector(
                                onTap: () {
                                  // showDialog 구현
                                },
                                child: Column(
                                  children: [
                                    ClipOval(
                                      child: SvgPicture.asset(
                                        'assets/img/plus.svg',
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    Text('추가하기',
                                        style: TextStyle(
                                          color: Colors.black,
                                            fontSize: 15,
                                            fontWeight:
                                                FontWeight.w700)), // 텍스트 크기 조정
                                  ],
                                ),
                              );
                            }
                            // 나머지 아이템들
                            return Column(
                              children: [
                                ClipOval(
                                  child: SvgPicture.asset(
                                    'assets/img/plus.svg', // 추후 변경 가능
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                Text('알약${index}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey[500]
                                    )), // 텍스트 크기 조정
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: LoginNextButton(
                        onPressed: () {},
                        buttonName: '검사하기',
                        isButtonEnabled: true,
                        color: PRIMARY_BLUE_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}