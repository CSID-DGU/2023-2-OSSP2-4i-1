import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yakmoya/common/const/data.dart';
import 'package:yakmoya/common/dio/dio.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_search_model.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response.dart';

part 'pill_search_repository.g.dart';

final pillSearchRepositoryProvider = Provider<PillSearchRepository>((ref) {
  final dio = ref.watch(dioProvider);

  // Replace with the actual base URL of your API.
  return PillSearchRepository(dio, baseUrl: 'http://$ip/pill');
});


@RestApi()
abstract class PillSearchRepository {
  factory PillSearchRepository(Dio dio, {String baseUrl}) = _PillSearchRepository;

  @POST('/search')
  @Headers({
    'accessToken': 'true',
  })
  Future<List<SearchResponse>> postSearch({
    @Body() required PillSearchModel searchModel,
  });
}
