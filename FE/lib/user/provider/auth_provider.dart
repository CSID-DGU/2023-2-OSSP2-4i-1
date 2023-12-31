import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yakmoya/image_search_screen.dart';
import 'package:yakmoya/pill/pill_picture/view/search_detail_screen.dart';
import 'package:yakmoya/pill/pill_picture/view/text_search_screen.dart';
import 'package:yakmoya/user/model/user_model.dart';
import 'package:yakmoya/user/provider/user_me_provider.dart';
import 'package:yakmoya/user/view/home_screen.dart';
import 'package:yakmoya/user/view/login_screen.dart';
import 'package:yakmoya/user/view/root_tab.dart';
import 'package:yakmoya/user/view/select_screen.dart';
import 'package:yakmoya/user/view/signup_screen.dart';
import 'package:yakmoya/user/view/splash_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(
      userMeProvider,
          (previous, next) {
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }

  List<GoRoute> get routes => [
    // 명심하자 -
    // /는 루트 경로로 인식된다
    //'interview' 아래에 ':rid'를 붙였을 때의 경로는 /interview/:rid 자동으로 /가 추가된다
    GoRoute(
      path: '/',
      name: RootTab.routeName,
      builder: (_, __) => RootTab(),
      routes: [
      ],
    ),
    GoRoute(
      path: '/signup',
      name: SignupScreen.routeName,
      builder: (_, state) => SignupScreen(),
      //restaurantScreen의 goNamed와 연결
    ),
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (_, __) => SplashScreen(),
    ),
    GoRoute(
      path: '/select',
      name: SelectScreen.routeName,
      builder: (_, __) => SelectScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.routeName,
      builder: (_, __) => LoginScreen(),
    ),

    GoRoute(
      path: '/text',
      name: TextSearchScreen.routeName,
      builder: (_, __) => TextSearchScreen(),
    ),
    GoRoute(
      path: '/pill/:id', // 경로 수정
      name: SearchDetailScreen.routeName,
      builder: (_, state) => SearchDetailScreen(id: state.pathParameters['id']!),
    ),

    GoRoute(
      path: '/image',
      name: ImageSearchScreen.routeName,
      builder: (_, __) => ImageSearchScreen(),
    ),

  ];

  logout() {
    ref.read(userMeProvider.notifier).logout();
    notifyListeners();
  }


  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    // 회원가입 페이지에서 회원가입 완료 후 로그인 페이지로 리다이렉트
    if (state.matchedLocation == '/signup' && user is UserModel) return '/';

    if (state.matchedLocation.startsWith('/signup')) return null;

    if (state.matchedLocation == '/login' && user is UserModel) return '/';

    if (!state.matchedLocation.startsWith('/login') && user == null) return '/select';

    if (user is UserModel &&
        (state.matchedLocation == '/select'
            || state.matchedLocation == '/login' ||
            state.matchedLocation == '/splash')) return '/';

    // if (user is UserModelError) return '/select';

    return null;
  }
}
