import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yakmoya/common/router/go_router.dart';
import 'package:yakmoya/user/view/home_screen.dart';
import 'package:yakmoya/user/view/select_screen.dart';
import 'image_search_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routeProvider);
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        theme: ThemeData(
          fontFamily: 'GmarketSans',
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: route,
        // supportedLocales: [
        //   const Locale('en', ''), // English
        //   const Locale('ko', ''), // Korean
        // ],
      ),
    );
  }
}

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