import 'package:floor/floor.dart';
import 'package:glint_frontend/domain/business_logic/models/common/swipe_action_type.dart';

class SwipeActionTypeConverter extends TypeConverter<SwipeActionType, String> {
  @override
  SwipeActionType decode(String databaseValue) {
    return SwipeActionType.values.firstWhere(
          (e) => e.toString().split('.').last == databaseValue,
      orElse: () => SwipeActionType.RIGHT,
    );
  }

  @override
  String encode(SwipeActionType value) {
    return value.toString().split('.').last;
  }
}