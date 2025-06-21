import 'package:floor/floor.dart';

import '../entities/user_event_like_entity.dart';

@dao
abstract class EventLikeDao {
  @Query('SELECT * FROM user_event_likes WHERE userId = :userId')
  Future<List<UserEventLikeEntity>> getLikedEvents(String userId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> likeEvent(UserEventLikeEntity entity);
}