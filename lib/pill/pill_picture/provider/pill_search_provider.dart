import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yakmoya/common/dio/dio.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_search_model.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';
import 'package:yakmoya/pill/pill_picture/repository/pill_search_repository.dart';

enum TextSearchStatus { initial, loading, success, zero, error }

enum PictureSearchStatus { initial, loading, success, zero, error }

class PillSearchState {
  final TextSearchStatus status;
  final PictureSearchStatus pictureSearchStatus;
  final List<SearchResponseModel> results; // 검색 결과를 저장하는 필드 추가

  PillSearchState({
    this.pictureSearchStatus = PictureSearchStatus.initial,
    this.status = TextSearchStatus.initial,
    this.results = const [],
  });

  PillSearchState copyWith({
    PictureSearchStatus? pictureSearchStatus,
    TextSearchStatus? status,
    List<SearchResponseModel>? results,
  }) {
    return PillSearchState(
      pictureSearchStatus: pictureSearchStatus ?? this.pictureSearchStatus,
      status: status ?? this.status,
      results: results ?? this.results,
    );
  }
}

final pillSearchStateNotifierProvider =
    StateNotifierProvider<PillSearchStateNotifier, PillSearchState>(
  (ref) {
    final repository = ref.watch(pillSearchRepositoryProvider);
    return PillSearchStateNotifier(repository: repository);
  },
);

class PillSearchStateNotifier extends StateNotifier<PillSearchState> {
  final PillSearchRepository repository;

  PillSearchStateNotifier({required this.repository})
      : super(
          PillSearchState(
            status: TextSearchStatus.initial,
            pictureSearchStatus: PictureSearchStatus.initial,
          ),
        );

  Future<void> searchImage(PillSearchModel searchModel) async {
    state = state.copyWith(pictureSearchStatus: PictureSearchStatus.loading);
    try {
      final response =
          await repository.getImageSearch(searchModel: searchModel);
      if (response.isNotEmpty) {
        state = state.copyWith(
          pictureSearchStatus: PictureSearchStatus.success,
          results: response,
        ); // 검색 결과가 있는 경우
      } else if (response.isEmpty) {
        state = state.copyWith(
          pictureSearchStatus: PictureSearchStatus.zero,
          results: response,
        ); // 검색 결과가 없는 경우
      }
    } catch (e) {
      state = state.copyWith(
        pictureSearchStatus: PictureSearchStatus.error,
        results: [],
      ); // 에러가 발생한 경우 결과를 빈 리스트로 설정
    } finally {
      // 필요한 경우 finally 블록을 사용하여 상태를 initial로 재설정
      resetPictureSearchStatus();
    }
  }

  void resetPictureSearchStatus() {
    state = state.copyWith(pictureSearchStatus: PictureSearchStatus.initial);
  }

  Future<void> searchText(String searchText) async {
    if (searchText.isEmpty) {
      // 검색 텍스트가 비어있는 경우
      state = state.copyWith(
          status: TextSearchStatus.initial,
          results: []); // 상태를 initial로 변경하고 결과를 빈 리스트로 설정
      return;
    }

    state = state.copyWith(status: TextSearchStatus.loading);
    try {
      final response = await repository.getTextSearch(searchText);
      if (response.isNotEmpty) {
        state = state.copyWith(
            status: TextSearchStatus.success,
            results: response); // 검색 결과가 있는 경우
      } else if (response.isEmpty) {
        state = state.copyWith(
            status: TextSearchStatus.zero, results: response); // 검색 결과가 없는 경우
      }
    } catch (e) {
      state = state.copyWith(
          status: TextSearchStatus.error,
          results: []); // 에러가 발생한 경우 결과를 빈 리스트로 설정
    }
  }
}
