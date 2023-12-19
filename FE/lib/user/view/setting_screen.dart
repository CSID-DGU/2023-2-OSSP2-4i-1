import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/const/text.dart';
import 'package:yakmoya/user/provider/user_me_provider.dart';
import 'package:yakmoya/user/view/alarm_setting_screen.dart';
import 'package:yakmoya/user/view/delete_screen.dart';

import '../../common/view/default_layout.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      title: '설정',
      child: Column(
        children: [
          Divider(
            color: Colors.grey[400],
            thickness: 0.5,
          ),
          SettingComponent(
            title: '알림 설정',
            otherScreen: AlarmSettingScreen(),
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 0.5,
          ),
          LogoutSettingComponent(
            title: '로그 아웃',
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 0.5,
          ),
          // SettingComponent(
          //   title: '이용 약관',
          //   otherScreen: RuleExplainScreen(),
          // ),
          // SettingComponent(
          //   title: '개인정보처리방침',
          //   otherScreen: PersonalInfo(),
          // ),
          SettingComponent(
            title: '버전 정보',
            otherScreen: VersionInfoScreen(),
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 0.5,
          ),
          SettingComponent(
            title: '회원 탈퇴',
            otherScreen: DeleteUserScreen(),
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}

class SettingComponent extends StatelessWidget {
  final String title;
  final Widget otherScreen;
  const SettingComponent({
    required this.title,
    required this.otherScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => otherScreen),
          );
        },
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: GREY_COLOR,
        ),
      ),
    );
  }
}

class LogoutSettingComponent extends ConsumerWidget {
  final String title;
  const LogoutSettingComponent({
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: SizedBox(
                  height: 65, // Increase the height of the AlertDialog
                  child: Center(
                    child: Text(
                      '로그아웃 하시겠습니까?',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      Container(
                        width: 125,
                        decoration: BoxDecoration(
                          color:
                              SUB_BLUE_COLOR, // Background color for the '아니오' button
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, '아니오');
                          },
                          style: TextButton.styleFrom(
                            primary:
                                Colors.white, // Set the text color to white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Match container's border radius
                            ),
                          ),
                          child: Text(
                            '아니요',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 125,
                        decoration: BoxDecoration(
                          color: GREY_COLOR,
                          borderRadius: BorderRadius.circular(
                              10), // Rounded corners for the '예' button
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, '예');
                          },
                          style: TextButton.styleFrom(
                            primary: Colors
                                .white, // Set the text color for the '예' button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Match container's border radius
                            ),
                          ),
                          child: Text(
                            '예',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ).then((value) {
            if (value == '예') {
              // logout(context);
              ref.read(userMeProvider.notifier).logout();
            }
          });
        },
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        splashColor: Colors.transparent, // 그림자 효과 비활성화
      ),
    );
  }
}

class VersionInfoScreen extends StatelessWidget {
  const VersionInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      title: '버전 정보',
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SizedBox(width: 60),
                Image.asset(
                  'assets/img/realapplogo.png',
                  width: 100,
                ),
                Text(
                  '약모야',
                  style: TextStyle(
                    fontSize: 53,
                    fontWeight: FontWeight.bold,
                    color: SUB_BLUE_COLOR,
                    fontFamily: 'Jalnan2', // 폰트 적용
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 350,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: SUB_BLUE_COLOR,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            '안녕하세요! 약모야입니다.',
                            style: TextStyle(
                              color: GREY_PRIMARY_COLOR,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '약모야는 알약 객체 인식 서비스를 제공하는 앱입니다.',
                            style: TextStyle(
                              color: GREY_PRIMARY_COLOR,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '약의 이름을 모르거나,\n약에 대한 정보를 잃어버렸을때\n',
                            style: TextStyle(
                              color: GREY_PRIMARY_COLOR,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '약모야의 도움을 받으세요!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: SUB_BLUE_COLOR,
                              fontFamily: 'Jalnan2',
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(), // This takes up the remaining space
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            const Text(
              '현재 버전은 1.1.0입니다.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: SUB_BLUE_COLOR,
                fontFamily: 'Jalnan2',
                fontSize: 30,
              ),
            ), // 폰트 적용,)
          ],
        ),
      ),
    );
  }
}
