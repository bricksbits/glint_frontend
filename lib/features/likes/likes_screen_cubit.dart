import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/likes/likes_data_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'likes_screen_state.dart';

part 'likes_screen_cubit.freezed.dart';

class LikesScreenCubit extends Cubit<LikesScreenState> {
  final likesRepo = getIt.get<LikesDataRepo>();

  LikesScreenCubit() : super(const LikesScreenState.initial()) {
    _fetchProfileViewCount();
  }

  Future<void> likedScreenFacade() async {
    emitNewState(state.copyWith(isLoading: true));
    final requiredCalls = [
      _fetchLikedProfiles(),
      _fetchLikedProfiles(),
      _fetchSuperLikedProfiles(),
      _fetchTopProfiles()
    ];

    await Future.wait(requiredCalls);
    emitNewState(state.copyWith(isLoading: false));
  }

  Future<void> _fetchProfileViewCount() async {
    final profileViewsResult = await likesRepo.getUserProfileViews();
    switch (profileViewsResult) {
      case Success<int>():
        emitNewState(state.copyWith(profileViewCount: profileViewsResult.data));
        break;
      case Failure<int>():
        emitNewState(state.copyWith(error: "Can't fetch the profile counts,"));
        break;
    }
  }

  Future<void> _fetchTopProfiles() async {
    final topProfiles = await likesRepo.getTopProfiles();
    switch (topProfiles) {
      case Success<List<PeopleCardModel>>():
        emitNewState(
          state.copyWith(topProfiles: topProfiles.data),
        );
        break;
      case Failure<List<PeopleCardModel>>():
        emitNewState(
          state.copyWith(error: "Can't fetch top profiles"),
        );
        break;
    }
  }

  Future<void> _fetchSuperLikedProfiles() async {
    final superLikedProfiles = await likesRepo.getSuperLikedProfiles();
    switch (superLikedProfiles) {
      case Success<List<PeopleCardModel>>():
        emitNewState(
          state.copyWith(superLikeProfiles: superLikedProfiles.data),
        );
        break;
      case Failure<List<PeopleCardModel>>():
        emitNewState(
          state.copyWith(error: "Can't fetch super liked profiles"),
        );
        break;
    }
  }

  Future<void> _fetchLikedProfiles() async {
    final likedProfiles = await likesRepo.getLikedProfiles();
    switch (likedProfiles) {
      case Success<List<PeopleCardModel>>():
        emitNewState(
          state.copyWith(superLikeProfiles: likedProfiles.data),
        );
        break;
      case Failure<List<PeopleCardModel>>():
        emitNewState(
          state.copyWith(error: "Can't fetch liked profiles"),
        );
        break;
    }
  }

  void emitNewState(LikesScreenState newState) {
    emit(newState);
  }
}
