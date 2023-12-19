import 'dart:io';

//SharedPreferences 사용 변수들 (key)
const String darkModeState = 'dark_mode_state';
const String userId = "user_id";
const String userPassword = "user_password";
//const String loginState = "login_state";
const String autoLoginKey = 'autoLogin';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
// localhost
final emulatorIp = '10.0.2.2:3000';
final simulatorIp = '127.0.0.1:3000';

// final ip = Platform.isIOS ? simulatorIp : emulatorIp;


final ip = 'ec2-13-53-39-131.eu-north-1.compute.amazonaws.com';
