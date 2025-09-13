import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_repo.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';

import '../../../../di/injection.dart';
import '../../../../utils/result_sealed.dart';

part 'view_story_state.dart';

part 'view_story_cubit.freezed.dart';

class ViewStoryCubit extends Cubit<ViewStoryState> {
  final ChatRepo chatRepo = getIt.get<ChatRepo>();

  ViewStoryCubit() : super(const ViewStoryState.initial()) {
    _getStories();
  }

  Future<void> _getStories() async {
    updateState(state.copyWith(isLoading: true));
    final response = await chatRepo.fetchStories();
    switch (response) {
      case Success<List<ViewStoryModel>>():
        final stories = response.data;
        updateState(
          state.copyWith(
            isLoading: false,
            stories: stories,
          ),
        );
      case Failure<List<ViewStoryModel>>():
        updateState(
          state.copyWith(error: "Not able to fetch more stories, right now."),
        );
    }
  }

  void updateState(ViewStoryState newState) {
    emit(newState);
  }
}
