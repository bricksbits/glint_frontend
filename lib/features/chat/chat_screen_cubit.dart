import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_repo.dart';
import 'package:glint_frontend/features/chat/story/model/recent_matches_model.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'chat_screen_state.dart';

part 'chat_screen_cubit.freezed.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  final ChatRepo chatRepo = getIt.get<ChatRepo>();

  ChatScreenCubit() : super(const ChatScreenState.initial()) {
    _getRecentMatches();
  }

  Future<void> _getRecentMatches() async {
    final response = await chatRepo.fetchRecentMatches();
    switch (response) {
      case Success<List<RecentMatchesModel>>():
        final matches = response.data;
        updateState(state.copyWith(recentMatches: matches));
      case Failure<List<RecentMatchesModel>>():
        updateState(
          state.copyWith(error: "Not able to fetch recent Matches, right now."),
        );
    }
  }

  void updateState(ChatScreenState newState) {
    emit(newState);
  }
}
