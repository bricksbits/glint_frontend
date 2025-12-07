import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_repo.dart';
import 'package:glint_frontend/features/chat/story/model/recent_matches_model.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart'
    show
        StreamChatClient,
        User,
        ConnectionStatus,
        StreamChannelListController,
        StreamChatError;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
    show Filter, SortOption;

import '../../data/local/persist/shared_pref_key.dart';

part 'chat_screen_state.dart';

part 'chat_screen_cubit.freezed.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  final ChatRepo chatRepo = getIt.get<ChatRepo>();
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper =
      getIt.get();
  final StreamChatClient chatClient = getIt.get<StreamChatClient>();
  StreamSubscription<Result<List<RecentMatchesModel>>>?
      _recentMatchesSubscription;
  late final StreamChannelListController? _channelListController;

  ChatScreenCubit() : super(const ChatScreenState.initial()) {
    _getRecentMatches();
    _observeRecentMatches();
    _connectToStreamClient();
    _checkChatClientStatus();
  }

  Future<void> _observeRecentMatches() async {
    _recentMatchesSubscription = chatRepo.recentMatchesStreamGetter().listen(
      (recentMatchesResponse) {
        switch (recentMatchesResponse) {
          case Success<List<RecentMatchesModel>>():
            final matches = recentMatchesResponse.data;
            updateState(state.copyWith(recentMatches: matches));
            break;
          case Failure<List<RecentMatchesModel>>():
            updateState(
              state.copyWith(
                  error: "Not able to fetch recent Matches, right now."),
            );
            break;
        }
      },
    );
  }

  Future<void> _getRecentMatches() async {
    await chatRepo.fetchRecentMatches();
  }

  Future<void> _connectToStreamClient() async {
    updateState(state.copyWith(isLoading: true));
    final userId = await getUserId();
    final userToken = await getUserToken(userId);
    final userName = await getUserName();
    final userImage = await getUserImage();
    if (chatClient.wsConnectionStatus == ConnectionStatus.disconnected) {
      try {
        await chatClient.connectUser(
          User(id: userId, name: userName, image: userImage),
          userToken,
        );
        setupTheChannelListController(chatClient, userId);
      } on StreamChatError catch (streamError) {
        debugLogger("CHAT", "Stream Error : ${streamError.message}");
        updateState(state.copyWith(
          isLoading: false,
          isChatReady: false,
          error: "Chat Server went busy, please try again later",
        ));
      }
    } else {
      setupTheChannelListController(chatClient, userId);
    }
  }

  Future<String> getUserImage() async {
    final pic = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.userPrimaryPicUrlKey);
    return pic;
  }

  Future<String> getUserId() async {
    final userId =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    return userId;
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

  void setupTheChannelListController(
    StreamChatClient client,
    String currentUserId,
  ) {
    _channelListController = StreamChannelListController(
      client: chatClient,
      filter: Filter.in_(
        'members',
        [currentUserId],
      ),
      channelStateSort: const [SortOption('last_message_at', direction: -1)],
      limit: 42,
    );
    _channelListController?.doInitialLoad();
    updateState(
      state.copyWith(
        channelListController: _channelListController,
        isChatReady: true,
        isLoading: false,
      ),
    );
  }

  void updateState(ChatScreenState newState) {
    emit(newState);
  }

  @override
  Future<void> close() {
    _channelListController?.dispose();
    _recentMatchesSubscription?.cancel();
    chatRepo.disposeRecentChatStream();
    return super.close();
  }

  void _checkChatClientStatus() {
    chatClient.wsConnectionStatusStream.listen((status) {
      debugLogger("STREAM_CHAT_CONNECTION_STATUS", status.name);
    });
  }
}
