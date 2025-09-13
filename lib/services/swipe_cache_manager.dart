import 'dart:async';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/dao/swipe_action_dao.dart';
import 'package:glint_frontend/data/local/db/entities/swipe_action_entity.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/people/user_action_request_model.dart';
import 'package:glint_frontend/data/remote/model/response/people/user_action_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/common/swipe_action_type.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:injectable/injectable.dart';

import '../data/remote/client/http_request_enum.dart';
import '../utils/result_sealed.dart';

/// A service to buffer swipe actions in local DB and batch-send them to server.
/// Handles:
/// - Debounced flushing every 10 seconds
/// - Early flush if 10 swipes are reached
/// - Safe retry logic if app is paused
//Todo: Call the Flush Buffer on app Pause and when dispose
@singleton
class SwipeBufferManager {
  final SwipeActionDao swipeActionDao;
  final ProfileDao profileDao;
  final MyDioClient httpClient;

  Timer? _debounceTimer;
  bool _isProcessing = false;
  Duration debounceDuration = const Duration(seconds: 5);
  int batchSize = 5;
  String logPrefix = "BUFFER_MANAGER_SWIPES";

  SwipeBufferManager(
    this.httpClient, {
    required this.profileDao,
    required this.swipeActionDao,
  });

  /// Call this method whenever user swipes a profile.
  /// Add the Swipe Item to SwipeAction Entity and
  /// Remove the item from the Profile Entity
  Future<void> bufferSwipe(SwipeActionEntity swipe) async {
    debugLogger(logPrefix, "Item added to buffer, ${swipe.swipedOnUserId}");
    await swipeActionDao.insertSwipe(swipe);
    await profileDao.deleteAlreadySwipedOnProfile(
      int.parse(
        swipe.swipedOnUserId,
      ),
    );

    // Reset debounce timer
    _debounceTimer?.cancel();
    _debounceTimer = Timer(debounceDuration, _flushBuffer);

    // If we've reached batchSize early, flush immediately
    final count = (await swipeActionDao.getAllSwipes()).length;
    if (count >= batchSize) {
      await _flushBuffer();
    }
  }

  /// Should be called on app pause (e.g., in dispose or app lifecycle event)
  /// Todo: Should be called from parent Layout of Home Screen
  Future<void> flushOnAppPause() async {
    _debounceTimer?.cancel();
    await _flushBuffer();
  }

  /// Flushes swipe actions from DB in batches
  Future<void> _flushBuffer() async {
    if (_isProcessing) return;

    _isProcessing = true;

    try {
      List<SwipeActionEntity> allSwipes = await swipeActionDao.getAllSwipes();

      while (allSwipes.isNotEmpty) {
        final batch = allSwipes.take(batchSize).toList();

        // Make your API call here
        final success = await _sendBatchToServer(batch);

        if (success) {
          final ids = batch.map((e) => e.collabId).toList();
          await swipeActionDao.deleteSwipesById(ids);
          allSwipes = allSwipes.skip(batchSize).toList();
        } else {
          // Retry next time: keep data in DB
          break;
        }
      }
    } catch (e) {
      print('[SwipeBufferManager] Error during flush: $e');
    } finally {
      _isProcessing = false;
    }
  }

  /// Todo: Send the Batches of the files here
  /// Todo: Add Analytics when number of matches missed,
  Future<bool> _sendBatchToServer(List<SwipeActionEntity> batch) async {
    debugLogger(logPrefix, "${batch.length} Items Processing to Server");
    var userActionRequestModel = batch
        .map((item) => Actions(
            onUserId: int.parse(item.swipedOnUserId),
            action: switch (item.action) {
              SwipeActionType.RIGHT => "right swipe",
              SwipeActionType.LEFT => "left swipe",
              SwipeActionType.SUPER_LIKE => "super like",
            }))
        .toList();

    var requestModel = UserActionRequestModel(actions: userActionRequestModel);
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "user/action",
      requestBody: requestModel.toJson(),
    );

    switch (response) {
      case Success():
        final postActions = UserActionResponse.fromJson(response.data);
        if (postActions.message?.actionResponseList != null) {
          var actionSuccessfulOn = postActions.message?.actionResponseList
              ?.map((action) => action.userId);
          if (actionSuccessfulOn?.length != batch.length) {
            debugLogger(logPrefix, "SWIPE Actions : Few Id's swipe missed");
          }
          debugLogger(logPrefix, "${batch.length} Process Completed");
          return true;
        }
        return false;
      case Failure():
        debugLogger(logPrefix, "${batch.length} Process Failed");
        return false;
    }
  }

  /// Clean up any timers or tasks
  void dispose() {
    _debounceTimer?.cancel();
  }
}
