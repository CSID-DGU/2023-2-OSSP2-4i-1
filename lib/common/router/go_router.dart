import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/user/provider/auth_provider.dart';

final routeProvider = Provider<GoRouter>(
      (ref) {
    //watch - 값 변경될때마다 빌드
    //read - 1번만 읽고 값 변경되도 재빌드 X
    final provider = ref.read(authProvider);

    return GoRouter(
      routes: provider.routes,
      initialLocation: '/',
      refreshListenable: provider,
      redirect: provider.redirectLogic,
    );
  },
);
