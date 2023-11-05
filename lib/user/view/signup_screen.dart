import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/common/component/custom_text_form_field.dart';
import 'package:yakmoya/common/component/login_next_button.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/const/text.dart';

import '../../common/view/default_layout.dart';

extension InputValidate on String {
  // 이메일 포맷 검증
  bool isValidEmailFormat() {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }

  // 대쉬를 포함하는 010 휴대폰 번호 포맷 검증 (010-1234-5678)
  bool isValidPhoneNumberFormat() {
    return RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(this);
  }
}

class SignupScreen extends ConsumerStatefulWidget {
  static String get routeName => 'signup';

  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();

  bool isEmailValid = false;
  bool isNameValid = false;
  bool isNickNameValid = false;
  bool isPhoneNumValid = false;
  bool isPasswordValid = false;
  bool isPasswordCheckValid = false;
  bool isButtonEnabled = false;

  String? nicknameErrorText;
  String? ageErrorText;
  String? phoneNumErrorText;
  String? emailErrorText;
  String? emailValidText;
  String? accountErrorText;
  String? passwordErrorText;
  String? passwordDifferentErrorText;

  void checkNickNameEnabled() {
    String name = nicknameController.text.trim();
    bool isValid = RegExp(r'^[a-zA-Z가-힣]{2,}$').hasMatch(name);

    setState(() {
      isNickNameValid = isValid;
      nicknameErrorText = isValid ? null : '영문자 또는 한글로 2자 이상 입력해주세요!';
    });
  }

  void checkPhoneNumEnabled() {
    String number = phoneNumController.text.trim();
    bool isValid = number.isValidPhoneNumberFormat();

    setState(() {
      isPhoneNumValid = isValid;
      phoneNumErrorText = isValid ? null : '올바른 전화번호 형식이 아닙니다';
    });
    checkButtonEnabled();
  }

  void checkEmailEnabled() {
    String email = emailController.text.trim();
    bool isValid = email.isValidEmailFormat();

    setState(() {
      isEmailValid = isValid;
      emailErrorText = isValid ? null : '이메일 형식에 알맞게 입력해주세요';
    });
    checkButtonEnabled();
  }


  void checkPasswordEnabled() {
    String password = passwordController.text.trim();
    bool isValid = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$')
        .hasMatch(password);

    if (!isValid) {
      passwordErrorText = '8~16자 영문, 숫자, 특수문자를 사용하세요';
    }

    setState(() {
      isPasswordValid = isValid;
      // 아래 변수는 뷰에서 표시되는 에러 메시지로 사용될 수 있습니다.
      passwordErrorText = passwordErrorText;
    });
    checkButtonEnabled();
  }

  void checkSamePasswordEmabled(){
    String password = passwordController.text;
    String passwordCheck = passwordCheckController.text;

    setState(() {
      isPasswordCheckValid = password == passwordCheck;
    });
    checkButtonEnabled();
  }


  void checkButtonEnabled() {
    setState(() {
      isButtonEnabled =
          isEmailValid && isPasswordValid && isPasswordCheckValid && isNickNameValid && isPhoneNumValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '회원가입',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/img/small_logo.png',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  '회원정보를 입력해주세요',
                  style: textBrownStyle,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '이메일',
                style: signupReqStyle,
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomTextFormField(
                      controller: emailController,
                      hintText: '이메일을 입력해주세요',
                      onChanged: (String value) {
                        checkEmailEnabled();
                      },
                      errorText: isEmailValid ? null : emailErrorText,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 10, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          // ref
                          //     .read(authRepositoryProvider)
                          //     .checkEmail(emailController.text)
                          //     .then((response) {
                          //   if (response != null &&
                          //       response.status == "success") {
                          //     isEmailValid = true;
                          //     showDialog(
                          //       context: context,
                          //       builder: (BuildContext context) {
                          //         return AlertDialog(
                          //           title: Text(response.message),
                          //           content: Text(response.message ?? ""),
                          //           actions: <Widget>[
                          //             TextButton(
                          //               child: Text("OK"),
                          //               onPressed: () {
                          //                 Navigator.of(context).pop();
                          //               },
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );
                          //   } else {
                          //     isEmailValid = false;
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //             content: Text(
                          //                 response?.message ?? "중복된 아이디 입니다")));
                          //   }
                          // });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // 모서리 깎기
                          ),
                          padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                        ),
                        child: Text(
                          '중복확인',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '닉네임',
                style: signupReqStyle,
              ),
              CustomTextFormField(
                controller: nicknameController,
                hintText: '닉네임을 입력해 주세요',
                onChanged: (String value) {
                  checkNickNameEnabled();
                },
                errorText: isNickNameValid ? null : nicknameErrorText,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '휴대폰 번호',
                style: signupReqStyle,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 8, // 비율을 사용하여 width를 조절
                    child: CustomTextFormField(
                      controller: phoneNumController,
                      hintText: '번호를 입력해 주세요(' '-' '포함)',
                      onChanged: (String value) {
                        checkPhoneNumEnabled();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 10, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          // ref
                          //     .read(authRepositoryProvider)
                          //     .checkEmail(emailController.text)
                          //     .then((response) {
                          //   if (response != null &&
                          //       response.status == "success") {
                          //     isEmailValid = true;
                          //     showDialog(
                          //       context: context,
                          //       builder: (BuildContext context) {
                          //         return AlertDialog(
                          //           title: Text(response.message),
                          //           content: Text(response.message ?? ""),
                          //           actions: <Widget>[
                          //             TextButton(
                          //               child: Text("OK"),
                          //               onPressed: () {
                          //                 Navigator.of(context).pop();
                          //               },
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );
                          //   } else {
                          //     isEmailValid = false;
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //             content: Text(
                          //                 response?.message ?? "중복된 아이디 입니다")));
                          //   }
                          // });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // 모서리 깎기
                          ),
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                        ),
                        child: Text(
                          '인증',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '비밀번호',
                style: signupReqStyle,
              ),
              CustomTextFormField(
                controller: passwordController,
                hintText: '8~16자의 영문, 숫자, 특수문자 포함',
                onChanged: (String value) {
                  checkPasswordEnabled();
                },
                obscureText: true,
                errorText: isPasswordValid ? null : passwordErrorText,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '비밀번호 확인',
                style: signupReqStyle,
              ),
              CustomTextFormField(
                controller: passwordCheckController,
                hintText: '재입력해 주세요',
                onChanged: (String value) {
                  checkSamePasswordEmabled();
                },
                obscureText: true,
                errorText: isPasswordCheckValid ? null : passwordDifferentErrorText,
              ),
              SizedBox(
                height: 30,
              ),
              LoginNextButton(
                onPressed: () {
                  if (isButtonEnabled) {
                    // try {
                    //   ref.read(userMeProvider.notifier).postUser(
                    //     SignupUserModel(
                    //       nickname: nicknameController.text.toString(),
                    //       username: emailController.text.toString(),
                    //       password: passwordController.text.toString(),
                    //       phoneNumber: phoneNumController.text.toString(),
                    //       confirmPassword:
                    //       passwordCheckController.text.toString(),
                    //     ),
                    //   );
                    //   print('성공적 수행');
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => LoginScreen(),
                    //     ),
                    //   );
                    // } catch (e) {
                    //   print(e);
                    //   print('에러');
                    // }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("모든 필드를 올바르게 입력해주세요!"),
                      ),
                    );
                  }
                },
                buttonName: '회원 가입하기',
                isButtonEnabled: isButtonEnabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

