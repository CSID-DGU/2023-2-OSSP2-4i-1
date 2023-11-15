import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/common/dio/dio.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_search_model.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response.dart';
import 'package:yakmoya/pill/pill_picture/repository/pill_search_repository.dart';

// PillSearchRepository에 대한 프로바이더
final pillSearchRepositoryProvider = Provider<PillSearchRepository>((ref) {
  final dio = ref.watch(dioProvider); // Dio 인스턴스를 가져옴
  return PillSearchRepository(dio, baseUrl: 'http://localhost:8000/pill/search');
});

// PillSearch 상태 관리를 위한 StateNotifier
class PillSearchStateNotifier extends StateNotifier<SearchResponse?> {
  final PillSearchRepository repository;

  PillSearchStateNotifier({required this.repository}) : super(null);

  // 이미지 검색
  Future<void> searchImage(PillSearchModel searchModel) async {
    try {
      final response = await repository.postImageSearch(searchModel: searchModel);
      state = response;
    } catch (e) {
      state = null; // 에러 처리
    }
  }

  // 텍스트 검색
  Future<void> searchText(String searchText) async {
    try {
      final response = await repository.getTextSearch(searchText);
      state = response;
    } catch (e) {
      state = null; // 에러 처리
    }
  }
}

// PillSearchStateNotifier에 대한 프로바이더
final pillSearchStateNotifierProvider = StateNotifierProvider<PillSearchStateNotifier, SearchResponse?>(
      (ref) {
    final repository = ref.watch(pillSearchRepositoryProvider);
    return PillSearchStateNotifier(repository: repository);
  },
);
