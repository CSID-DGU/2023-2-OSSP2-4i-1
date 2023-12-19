import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yakmoya/common/const/data.dart';
import 'package:yakmoya/common/dio/dio.dart';
import 'package:yakmoya/common/util/util.dart';
import 'package:yakmoya/user/model/login_response.dart';
import 'package:yakmoya/user/model/token_response.dart';

import '../../common/stoarge/secure_stoarge.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(baseUrl: 'http://$ip/authentication', dio: dio,ref: ref);
});

class AuthRepository {
  //baseUrl == http://$ip/auth
  final String baseUrl;
  final Dio dio;
  final ProviderRef ref;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
    required this.ref,
  });

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$email:$password');

    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'authorization': 'Basic $serialized',
        },
      ),
    );

    // 응답에서 쿠키 추출
    final cookies = resp.headers.map['set-cookie'];
    print(cookies);
    if (cookies != null && cookies.isNotEmpty) {
      // 첫 번째 쿠키를 ';' 기준으로 분할하여 첫 부분만 사용
      final fullCookie = cookies.first.split(';').first;
      print('parsedCookies$cookies');
      final storage = ref.watch(secureStorageProvider);
      // ';' 이전 부분만 저장
      await storage.write(key: 'cookies', value: fullCookie);
    }

    return LoginResponse.fromJson(
      resp.data,
    );
  }

  // Future<CheckResponse> checkEmail(String username) async {
  //   final resp = await dio.get('$baseUrl/check-username/$username');
  //   return CheckResponse.fromJson(resp.data);
  // }

  //Base64 테스팅되면 수정
  // Future<LoginResponse> login({
  //   required String username,
  //   required String password,
  // }) async {
  //   final serialized = DataUtils.plainToBase64('$username:$password');
  //
  //   final resp = await dio.post(
  //     '$baseUrl/login',
  //     options: Options(
  //       headers: {
  //         'authorization': 'Basic $serialized',
  //       },
  //     ),
  //   );
  //   return LoginResponse.fromJson(
  //     resp.data,
  //   );
  // }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
    );
    return TokenResponse.fromJson(
      resp.data,
    );
  }
}
