import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/auth/refresh_auth_token_response.dart';
import 'package:glint_frontend/notifications/background/stream_background_prefs.dart';
import 'package:glint_frontend/utils/app_config.dart';
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
    final cachedFcmToken = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.deviceFcmTokenKey);

    try {
      if (isUserDetailsAvailable(userId, userName, userStreamToken)) {
        await chatService.connectUserWithProvider(
          userId: userId,
          userName: userName,
          profileImageUrl: userProfile,
          tokenProvider: (id) => _getStreamToken(id),
        );

        chatService.registerDevice(
          cachedToken: cachedFcmToken.isNotEmpty ? cachedFcmToken : null,
        );

        // Update background-isolate prefs with the latest token so FCM
        // notifications can authenticate even after a refresh.
        final latestToken = await sharedPreferenceHelper
            .getString(SharedPreferenceKeys.streamTokenKey);
        StreamBackgroundPrefs.save(
          apiKey: AppConfig.streamApiKey,
          userId: userId,
          token: latestToken,
        );

        return const Result.success('');
      }
      return Failure(Exception(), message: "No User data found");
    } on _StreamAuthException catch (e) {
      debugLogger("[ChatRepo]", "Stream auth permanently failed: ${e.message}");
      return Failure(e, message: kStreamTokenExpiredMessage);
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

  // Called by the TokenProvider. Returns the stored token when still valid;
  // fetches a fresh one from the backend when expired.
  Future<String> _getStreamToken(String userId) async {
    final current = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.streamTokenKey);
    if (!_isStreamTokenExpired(current)) {
      return current;
    }
    debugLogger("[ChatRepo]", "Stream token expired — refreshing via backend");
    return _refreshStreamToken();
  }

  // Calls auth/v1/refresh with a clean Dio instance (no auth interceptor) to
  // avoid re-entrant 401 handling, saves all three tokens, and returns the
  // new stream token.
  Future<String> _refreshStreamToken() async {
    final refreshToken = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.refreshTokenKey);

    if (refreshToken.isEmpty) {
      throw const _StreamAuthException("No refresh token — user must re-login");
    }

    try {
      final freshDio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
      final response = await freshDio.post(
        'auth/v1/refresh',
        data: {'refresh_token': refreshToken},
      );

      final body =
          UniversalSuccessResponseBody<RefreshAuthTokenResponse>.fromJson(
        response.data,
        (json) => RefreshAuthTokenResponse.fromJson(json),
      );

      final newStreamToken = body.data?.streamAuthToken;
      if (newStreamToken == null || newStreamToken.isEmpty) {
        throw const _StreamAuthException(
            "Refresh response missing stream_auth_token");
      }

      await sharedPreferenceHelper.saveString(
          SharedPreferenceKeys.streamTokenKey, newStreamToken);
      final newAccess = body.data?.accessToken;
      if (newAccess != null && newAccess.isNotEmpty) {
        await sharedPreferenceHelper.saveString(
            SharedPreferenceKeys.accessTokenKey, newAccess);
      }
      final newRefresh = body.data?.refreshToken;
      if (newRefresh != null && newRefresh.isNotEmpty) {
        await sharedPreferenceHelper.saveString(
            SharedPreferenceKeys.refreshTokenKey, newRefresh);
      }

      debugLogger("[ChatRepo]", "Stream token refreshed successfully");
      return newStreamToken;
    } on DioException catch (e) {
      debugLogger("[ChatRepo]", "Token refresh request failed: ${e.message}");
      throw const _StreamAuthException("Token refresh request failed");
    }
  }

  bool isUserDetailsAvailable(
      String userId, String userName, String userToken) {
    if (userId.isEmpty || userName.isEmpty || userToken.isEmpty) {
      return false;
    }
    return true;
  }

  // Returns true when the JWT `exp` claim is in the past.
  bool _isStreamTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;
      final payload = base64Url.normalize(parts[1]);
      final claims = jsonDecode(utf8.decode(base64Url.decode(payload)))
          as Map<String, dynamic>;
      final exp = claims['exp'] as int?;
      if (exp == null) return false;
      return DateTime.now().millisecondsSinceEpoch > exp * 1000;
    } catch (_) {
      return false;
    }
  }
}

class _StreamAuthException implements Exception {
  final String message;
  const _StreamAuthException(this.message);
  @override
  String toString() => '_StreamAuthException: $message';
}
