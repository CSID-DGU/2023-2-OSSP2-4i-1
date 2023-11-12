import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yakmoya/common/router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yakmoya/user/view/home_screen.dart';
import 'package:yakmoya/user/view/select_screen.dart';
import 'camera_ex.dart';

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