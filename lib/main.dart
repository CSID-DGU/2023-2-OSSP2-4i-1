import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yakmoya/common/router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 다언어 설정
import 'package:yakmoya/user/view/camera_ex.dart';

Future<void> saveTokenToSecureStorage(String? token) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: 'firebase_token', value: token);
}


void getMyDeviceToken() async{
  final token = await FirebaseMessaging.instance.getToken();
  print('내 디바이스 토큰(여기가 첨이자 마지막):$token');
  await saveTokenToSecureStorage(token);
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});



  Widget build(BuildContext context, WidgetRef ref) {
    // final storage = ref.watch(secureStorageProvider);
    final route = ref.watch(routeProvider);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        theme: ThemeData(
          fontFamily: 'Pretendard',
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: route,
        localizationsDelegates: const [
          // 다언어 설정
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English
          const Locale('ko', ''), // Korean
        ],
      ),
    );
  }
}

final firebaseTokenProvider = StateProvider<String?>((ref) {
  return null; // 초기값은 null로 설정합니다.
});


// class MyApp extends ConsumerWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: CameraExample(), // CameraExample 위젯을 홈 화면으로 설정합니다.
//     );
//   }
// }