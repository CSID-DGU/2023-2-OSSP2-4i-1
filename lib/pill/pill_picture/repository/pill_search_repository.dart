import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yakmoya/common/const/data.dart';
import 'package:yakmoya/common/dio/dio.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_search_model.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';

part 'pill_search_repository.g.dart';

final pillSearchRepositoryProvider = Provider<PillSearchRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PillSearchRepository(dio, baseUrl: 'http://localhost:8000/pill/search');
});

@RestApi()
abstract class PillSearchRepository {
  factory PillSearchRepository(Dio dio, {String baseUrl}) = _PillSearchRepository;

  @GET('image')
  @Headers({'accessToken': 'true'})
  Future<List<SearchResponseModel>> postImageSearch({
    @Body() required PillSearchModel searchModel,
  });

  @GET('')
  @Headers({'accessToken': 'true'})
  Future<List<SearchResponseModel>> getTextSearch(@Query('text') String searchText);
}