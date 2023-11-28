

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/user/model/user_pill_model.dart';
import 'package:yakmoya/user/repository/user_me_repository.dart';

final pillsProvider = FutureProvider<UserPillModelBase>((ref) async {
  try {
    final userMeRepository = ref.watch(userMeRepositoryProvider);
    final pills = await userMeRepository.getPills();
    return UserPillModelSuccess(pills: pills);
  } catch (e) {
    return UserPillModelError(message: e.toString());
  }
});
