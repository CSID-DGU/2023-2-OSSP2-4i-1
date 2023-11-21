import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yakmoya/common/const/data.dart';
import 'package:yakmoya/common/dio/dio.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_detail_model.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_search_model.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';

part 'pill_search_repository.g.dart';

final pillSearchRepositoryProvider = Provider<PillSearchRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PillSearchRepository(dio, baseUrl: 'http://localhost:8000/pill/');
});

@RestApi()
abstract class PillSearchRepository {
  factory PillSearchRepository(Dio dio, {String baseUrl}) = _PillSearchRepository;

  @GET('search/image')
  @Headers({'accessToken': 'true'})
  Future<List<SearchResponseModel>> getImageSearch({
    @Body() required PillSearchModel searchModel,
  });

  @GET('search')
  @Headers({'accessToken': 'true'})
  Future<List<SearchResponseModel>> getTextSearch(@Query('text') String searchText);


  @GET('/{id}') //Detailrestaurant용
  @Headers({
    'accessToken': 'true',
  })
  Future<PillDetailModel> getPillDetail({
    @Path() required String id,
  });

}
