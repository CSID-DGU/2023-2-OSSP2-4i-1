import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakmoya/common/component/custom_dropdown_button.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/user/provider/user_me_provider.dart';
import 'package:yakmoya/user/view/pill_card.dart';
import 'package:yakmoya/user/view/splash_screen.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/component/login_next_button.dart';
import '../../common/const/text.dart';
import '../model/user_model.dart';
import '../model/user_pill_model.dart';

class AlarmScreen extends ConsumerStatefulWidget {
  const AlarmScreen({super.key});

  @override
  ConsumerState<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends ConsumerState<AlarmScreen> {
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
      return SplashScreen();
    }

    return DefaultLayout(
      backgroundColor: Colors.white,
      title: '약 알림 목록',
      child: Column(
        children: [
          Expanded(
            child: pills != null && pills.isNotEmpty
                ? ListView.builder(
                    itemCount: pills.length,
                    itemBuilder: (context, index) {
                      return PillCard(pills![index],context);
                    },
                  )
                : Center(child: Text('알약이 없습니다')), // pills가 null이거나 비어있을 경우
          ),
        ],
      ),
    );
  }
}

Widget PillCard(UserPillModel pill, BuildContext context) {
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

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Card(
      color: Colors.white,
      child: Container(
        width: 335,
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: PRIMARY_BLUE_COLOR,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Image.network(
              pill.img,
              height: 100,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                      child: Text(
                        parsePillName(pill.name) ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 45,
                            height: 21,
                            decoration: BoxDecoration(
                              color: PRIMARY_BLUE_COLOR,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: PRIMARY_BLUE_COLOR,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '아침',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            width: 45,
                            height: 21,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: PRIMARY_BLUE_COLOR,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '점심',
                                style: TextStyle(
                                  color: PRIMARY_BLUE_COLOR,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            width: 45,
                            height: 21,
                            decoration: BoxDecoration(
                              color: PRIMARY_BLUE_COLOR,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: PRIMARY_BLUE_COLOR,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '저녁',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              'assets/img/pencil.svg',
                              height: 35,
                            ),
                          ),
                          InkWell(
                            child: SvgPicture.asset(
                              'assets/img/trash.svg',
                              height: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}



class SignupAskLabel extends StatelessWidget {
  final String text;
  const SignupAskLabel({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 30,
      child: Text(
        text,
        style: customTextStyle,
        maxLines: 2,
      ),
    );
  }
}
