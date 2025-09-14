import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_repo.dart';
import 'package:glint_frontend/features/chat/story/model/recent_matches_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart'
    show StreamChatClient, User, ConnectionStatus;

import '../../data/local/persist/shared_pref_key.dart';

part 'chat_screen_state.dart';

part 'chat_screen_cubit.freezed.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  final ChatRepo chatRepo = getIt.get<ChatRepo>();
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper =
      getIt.get();
  final StreamChatClient chatClient = getIt.get<StreamChatClient>();

  ChatScreenCubit() : super(const ChatScreenState.initial()) {
    _getRecentMatches();
    _connectToStreamClient();
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

  Future<void> _connectToStreamClient() async {
    if (chatClient.wsConnectionStatus == ConnectionStatus.disconnected) {
      final userId = await getUserId();
      final userToken = await getUserToken(userId);
      final userName = await getUserName();
      await chatClient.connectUser(
        User(
          id: userId,
          name: userName,
        ),
        userToken,
      );
    }
  }

  Future<String> getUserId() async {
    final userId =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    return "user_$userId";
  }

  Future<String> getUserName() async {
    final userName = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.userNameKey);
    return userName;
  }

  Future<String> getUserToken(String userId) async {
    final userToken = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.streamTokenKey);
    return userToken;
  }

  void updateState(ChatScreenState newState) {
    emit(newState);
  }
}
