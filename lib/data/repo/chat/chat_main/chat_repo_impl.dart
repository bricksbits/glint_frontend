import 'dart:async';

import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/chat/get_recent_matches_response.dart';
import 'package:glint_frontend/data/remote/model/response/story/story_response_body.dart';
import 'package:glint_frontend/data/remote/model/response/universal/universal_success_response_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_repo.dart';
import 'package:glint_frontend/features/chat/story/model/recent_matches_model.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/services/chat_service.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as StreamChat;

@LazySingleton(as: ChatRepo)
class ChatRepoImpl extends ChatRepo {
  final MyDioClient httpClient;
  final ChatService chatService;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  final _recentMatchesController =
      StreamController<Result<List<RecentMatchesModel>>>.broadcast(sync: true);

  ChatRepoImpl(
    this.httpClient,
    this.chatService,
    this.sharedPreferenceHelper,
  );

  @override
  Future<Result<void>> fetchChannels() {
    // TODO: implement fetchChannels
    throw UnimplementedError();
  }

  @override
  Future<void> fetchRecentMatches() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/recent-matches",
    );

    switch (response) {
      case Success():
        final recentMatchesResponse =
            UniversalSuccessResponseBody<GetRecentMatchesResponse>.fromJson(
                response.data,
                (json) => GetRecentMatchesResponse.fromJson(json));
        if (recentMatchesResponse.success &&
            recentMatchesResponse.data != null) {
          final matches = recentMatchesResponse.data!.mapToUiModel();
          debugLogger("ChatRepo", "Is Recent Match Subscription Listening, ${_recentMatchesController.hasListener}");
          debugLogger("ChatRepo", "Is Recent Match Subscription Listening, ${_recentMatchesController.isClosed}");
          _recentMatchesController.add(Success(matches));
          break;
        }
      case Failure():
        _recentMatchesController.add(Failure(
          Exception("No Recent matches found"),
        ));
        break;
    }
  }

  @override
  Future<Result<List<ViewStoryModel>>> fetchStories() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/content/story",
    );

    switch (response) {
      case Success():
        final storiesResponse = StoryResponseBody.fromJson(response.data);
        if (storiesResponse.success == true && storiesResponse.data != null) {
          final stories = storiesResponse.mapToUiModel();
          return Success(stories);
        } else {
          return Failure(Exception(storiesResponse.message));
        }
      case Failure():
        return Failure(Exception("No stories found"));
    }
  }

  @override
  void disposeRecentChatStream() {
    _recentMatchesController.close();
  }

  @override
  Stream<Result<List<RecentMatchesModel>>> recentMatchesStreamGetter() {
    return _recentMatchesController.stream;
  }

  @override
  Future<Result<void>> connectToServer() async {
    final userId =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    final userName = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.userNameKey);
    final userProfile = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.userPrimaryPicUrlKey);
    final userStreamToken = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.streamTokenKey);

    try {
      if (isUserDetailsAvailable(userId, userName, userStreamToken)) {
        await chatService.connectUser(
          userId: userId,
          userName: userName,
          userToken: userStreamToken,
          profileImageUrl: userProfile,
        );
        return const Result.success('');
      }
      return Failure(Exception(), message: "No User data found");
    } on StreamChat.StreamChatError catch (streamError) {
      const errorMsg = "Stream server initialization failed";
      debugLogger("[ChatRepo]", errorMsg);
      return Failure(streamError, message: errorMsg);
    } on Exception catch (exc, st) {
      debugLogger(
          "[ChatRepo]", "Stream chat doesn't initialized, ${exc.toString()}");
      return Failure(exc, message: "Stream chat doesn't initialized");
    }
  }

  bool isUserDetailsAvailable(
      String userId, String userName, String userToken) {
    if (userId.isEmpty || userName.isEmpty || userToken.isEmpty) {
      return false;
    }

    return true;
  }
}
