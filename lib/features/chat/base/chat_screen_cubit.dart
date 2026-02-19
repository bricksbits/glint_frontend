import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_repo.dart';
import 'package:glint_frontend/features/chat/story/model/recent_matches_model.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/services/chat_service.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart'
    show
        StreamChatClient,
        User,
        ConnectionStatus,
        StreamChannelListController,
        StreamChatError,
        EventType;

import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
    show Filter, SortOption, Channel;

part 'chat_screen_state.dart';

part 'chat_screen_cubit.freezed.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  final ChatRepo chatRepo = getIt.get<ChatRepo>();
  final ChatService chatService = getIt.get<ChatService>();

  // Stream Managers and Controllers
  StreamSubscription<Result<List<RecentMatchesModel>>>?
      _recentMatchesSubscription;
  late final StreamChannelListController? _channelListController;
  late final StreamSubscription? _channelsEventsSubscription;

  ChatScreenCubit() : super(const ChatScreenState.initial()) {
    chatFacade();
  }

  void chatFacade() async {
    _getRecentMatches();
    _observeRecentMatches();
    _checkChatClientStatus();
    _getStories();
    setupTheChannelListController();
  }

  bool _isChatConnected() {
    final isChatConnected = chatService.isConnected;
    debugLogger(
        "ChatScreenCubit", "Is Chat Server connected, $isChatConnected");
    return isChatConnected;
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
    if (!_isChatConnected()) {
      chatRepo.connectToServer().then((onValue) {
        switch (onValue) {
          case Success<void>():
            setupTheChannelListController();
            updateState(state.copyWith(isLoading: false));
            break;
          case Failure<void>():
            updateState(state.copyWith(
              isLoading: false,
              error: onValue.message.toString(),
            ));
            break;
        }
      });
    }
  }

  void setupTheChannelListController() {
    if (!_isChatConnected()) {
      return;
    }
    _channelListController = StreamChannelListController(
      client: chatService.client,
      filter: Filter.and([
        Filter.equal('type', 'messaging'),
        Filter.in_(
          'members',
          [chatService.client.state.currentUser?.id ?? "0"],
        ),
      ]),
      channelStateSort: const [SortOption('last_message_at', direction: -1)],
      limit: 20,
      presence: true,
    );

    _channelListController?.doInitialLoad().then((_) {
      updateState(
        state.copyWith(
          channelListController: _channelListController,
          isChatReady: true,
          isLoading: false,
        ),
      );
    });

    _channelsEventsSubscription = chatService.client.on().listen((event) {
      if (event.type == EventType.messageNew ||
          event.type == EventType.notificationMessageNew ||
          event.type == EventType.channelUpdated ||
          event.type == EventType.notificationAddedToChannel) {
        debugLogger("CHAT", "Event received: ${event.type}");

        // Refresh the channel list
        _channelListController?.refresh();
      }
    });
  }

  void updateState(ChatScreenState newState) {
    emit(newState);
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
          state.copyWith(
            error: "Not able to fetch more stories, right now.",
            isLoading: false,
          ),
        );
    }
  }

  @override
  Future<void> close() {
    _channelListController?.dispose();
    _recentMatchesSubscription?.cancel();
    chatRepo.disposeRecentChatStream();
    _channelsEventsSubscription?.cancel();
    return super.close();
  }

  void _checkChatClientStatus() {
    chatService.client.wsConnectionStatusStream.listen(
      (status) {
        switch (status) {
          case ConnectionStatus.connected:
            debugLogger("STREAM_CHAT_CONNECTION_STATUS", status.name);
            break;
          case ConnectionStatus.connecting:
            debugLogger("STREAM_CHAT_CONNECTION_STATUS", status.name);
            break;
          case ConnectionStatus.disconnected:
            _connectToStreamClient();
            break;
        }
      },
    );
  }
}
