import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/common/const/colors.dart';
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
          Divider(color: Colors.grey[400],thickness: 0.5,),
          SettingComponent(
            title: '알림 설정',
            otherScreen: AlarmSettingScreen(),
          ),
          Divider(color: Colors.grey[400],thickness: 0.5,),
          LogoutSettingComponent(
            title: '로그 아웃',
          ),
          Divider(color: Colors.grey[400],thickness: 0.5,),
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
          Divider(color: Colors.grey[400],thickness: 0.5,),
          SettingComponent(
            title: '회원 탈퇴',
            otherScreen: DeleteUserScreen(),
          ),
          Divider(color: Colors.grey[400],thickness: 0.5,),
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
        trailing: Icon(Icons.arrow_forward_ios,color: GREY_COLOR,),
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
                              fontSize: 15,
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
                          color: Colors.grey[400],
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
                              fontSize: 15,
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
            Image.asset('"assets/img/realapplogo.png"'),
            const Text('현재 버전은 1.1.0입니다.',style: TextStyle(fontSize: 30,color: PRIMARY_BLUE_COLOR),),
          ],
        ),
      ),
    );
  }
}