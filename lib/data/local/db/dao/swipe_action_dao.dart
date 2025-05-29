import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/entities/swipe_action_entity.dart';

@dao
abstract class SwipeActionDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSwipe(SwipeActionEntity swipe);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSwipes(List<SwipeActionEntity> swipes);

  @Query('SELECT * FROM swipe_actions ORDER BY timestamp ASC')
  Future<List<SwipeActionEntity>> getAllSwipes();

  @Query('SELECT * FROM swipe_actions ORDER BY timestamp ASC')
  Stream<List<SwipeActionEntity>> watchAllSwipes();

  @Query('DELETE FROM swipe_actions WHERE collabId IN (:ids)')
  Future<void> deleteSwipesById(List<int> ids);

  @Query('DELETE FROM swipe_actions')
  Future<void> clearAll();
}