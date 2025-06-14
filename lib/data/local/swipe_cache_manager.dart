import 'dart:async';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/dao/swipe_action_dao.dart';
import 'package:glint_frontend/data/local/db/entities/swipe_action_entity.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:injectable/injectable.dart';

/// A service to buffer swipe actions in local DB and batch-send them to server.
/// Handles:
/// - Debounced flushing every 10 seconds
/// - Early flush if 10 swipes are reached
/// - Safe retry logic if app is paused

@singleton
class SwipeBufferManager {
  final SwipeActionDao swipeActionDao;
  final ProfileDao profileDao;
  final MyDioClient httpClient;

  Timer? _debounceTimer;
  bool _isProcessing = false;
  Duration debounceDuration = const Duration(seconds: 10);
  int batchSize = 10;

  SwipeBufferManager(
    this.httpClient, {
    required this.profileDao,
    required this.swipeActionDao,
  });

  /// Call this method whenever user swipes a profile.
  /// Add the Swipe Item to SwipeAction Entity and
  /// Remove the item from the Profile Entity
  Future<void> bufferSwipe(SwipeActionEntity swipe) async {
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
  Future<bool> _sendBatchToServer(List<SwipeActionEntity> batch) async {
    try {
      print("Sending ${batch.length} swipes to server...");
      // Simulate success response
      await Future.delayed(const Duration(milliseconds: 300));
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Clean up any timers or tasks
  void dispose() {
    _debounceTimer?.cancel();
  }
}
