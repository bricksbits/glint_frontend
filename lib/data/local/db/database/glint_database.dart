import 'dart:async';

import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/dao/event_like_dao.dart';
import 'package:glint_frontend/data/local/db/dao/membership_dao.dart';
import 'package:glint_frontend/data/local/db/dao/swipe_action_dao.dart';
import 'package:glint_frontend/data/local/db/database/string_type_converter.dart';
import 'package:glint_frontend/data/local/db/database/swipe_action_type_converter.dart';
import 'package:glint_frontend/data/local/db/entities/swipe_action_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/data/local/db/entities/user_event_like_entity.dart';

import 'date_time_converter.dart';

part 'glint_database.g.dart';

@TypeConverters(
    [StringTypeConverter, SwipeActionTypeConverter, DateTimeConverter])
@Database(
  version: 1,
  entities: [
    ProfileEntity,
    SwipeActionEntity,
    ProfileMembershipEntity,
    UserEventLikeEntity,
  ],
)
abstract class GlintDatabase extends FloorDatabase {
  ProfileDao get profileDao;

  MembershipDao get membershipDao;

  EventLikeDao get eventLikeDao;

  SwipeActionDao get swipeActionDao;
}
