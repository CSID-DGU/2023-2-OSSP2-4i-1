import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/common/dio/dio.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_search_model.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';
import 'package:yakmoya/pill/pill_picture/repository/pill_search_repository.dart';

enum SearchStatus { initial, loading, success, zero, error}

class PillSearchState {
  final SearchStatus status;
  final List<SearchResponseModel> results; // 검색 결과를 저장하는 필드 추가

  PillSearchState({this.status = SearchStatus.initial, this.results = const []});

  PillSearchState copyWith({
    SearchStatus? status,
    List<SearchResponseModel>? results,
  }) {
    return PillSearchState(
      status: status ?? this.status,
      results: results ?? this.results,
    );
  }
}

// PillSearchRepository에 대한 프로바이더
final pillSearchRepositoryProvider = Provider<PillSearchRepository>((ref) {
  final dio = ref.watch(dioProvider); // Dio 인스턴스를 가져옴
  return PillSearchRepository(dio, baseUrl: 'http://localhost:8000/pill/search');
});

class PillSearchStateNotifier extends StateNotifier<PillSearchState> {
  final PillSearchRepository repository;

  PillSearchStateNotifier({required this.repository})
      : super(PillSearchState(status: SearchStatus.initial));

  // Future<void> searchImage(PillSearchModel searchModel) async {
  //   state = state.copyWith(status: SearchStatus.loading);
  //   try {
  //     final response = await repository.postImageSearch(searchModel: searchModel);
  //     state = state.copyWith(status: SearchStatus.success);
  //   } catch (e) {
  //     state = state.copyWith(status: SearchStatus.error);
  //   }
  // }

  Future<void> searchText(String searchText) async {
    if (searchText.isEmpty) {  // 검색 텍스트가 비어있는 경우
      state = state.copyWith(status: SearchStatus.initial, results: []);  // 상태를 initial로 변경하고 결과를 빈 리스트로 설정
      return;
    }

    state = state.copyWith(status: SearchStatus.loading);
    try {
      final response = await repository.getTextSearch(searchText);
      if (response.isNotEmpty) {
        state = state.copyWith(status: SearchStatus.success, results: response);  // 검색 결과가 있는 경우
      } else if (response.isEmpty) {
        state = state.copyWith(status: SearchStatus.zero, results: response);  // 검색 결과가 없는 경우
      }
    } catch (e) {
      state = state.copyWith(status: SearchStatus.error, results: []);  // 에러가 발생한 경우 결과를 빈 리스트로 설정
    }
  }

}


final pillSearchStateNotifierProvider = StateNotifierProvider<PillSearchStateNotifier, PillSearchState>(
      (ref) {
    final repository = ref.watch(pillSearchRepositoryProvider);
    return PillSearchStateNotifier(repository: repository);
  },
);
