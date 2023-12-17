import 'package:flutter/material.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/user/view/login_screen.dart';

import 'signup_screen.dart';

class SelectScreen extends StatelessWidget {
  static String get routeName => 'select';

  const SelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 270,),
              Row(
                children: [
                  SizedBox(width: 60),
                  Image.asset(
                    'assets/img/realapplogo.png',
                    width: 90,
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
                height: 190,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_BLUE_COLOR,
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            width: 2,
                            color: PRIMARY_BLUE_COLOR,
                          )),
                    ),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_BLUE_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 1,
                          color: PRIMARY_BLUE_COLOR,
                        ),
                      ),
                    ),
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
