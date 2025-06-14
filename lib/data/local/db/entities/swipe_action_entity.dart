import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/database/date_time_converter.dart';
import 'package:glint_frontend/data/local/db/database/swipe_action_type_converter.dart';
import 'package:glint_frontend/domain/business_logic/models/common/swipe_action_type.dart';

@Entity(tableName: 'swipe_actions')
class SwipeActionEntity {
  @PrimaryKey(autoGenerate: true)
  final int collabId;
  final String currentUserId;
  final String swipedOnUserId;
  final bool isUnsent;

  @TypeConverters([SwipeActionTypeConverter])
  final SwipeActionType action;

  @TypeConverters([DateTimeConverter])
  final DateTime timestamp;

  SwipeActionEntity(
      {required this.collabId,
      required this.currentUserId,
      required this.swipedOnUserId,
      this.isUnsent = false,
      required this.action,
      required this.timestamp});
}
