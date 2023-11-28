import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yakmoya/common/dio/dio.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';
import 'package:yakmoya/user/model/signup_user_model.dart';
import 'package:yakmoya/user/model/user_model.dart';
import 'package:yakmoya/user/model/user_pill_model.dart';

import '../../common/const/data.dart';
import '../model/signup_response.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return UserMeRepository(dio, baseUrl: 'http://$ip/user');
  },
);

// http://$ip/user/me
@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<UserModel> getMe();

  @GET('/pill')
  @Headers({
    'accessToken': 'true',
  })
  Future<List<UserPillModel>> getPills();

  @POST('/register')
  Future<SignupResponse> postUser(@Body() SignupUserModel user);

  @GET('/logout')
  @Headers({
    'accessToken': 'true',
  })
  Future<String> logout();

}
