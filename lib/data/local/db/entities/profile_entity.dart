import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/database/string_type_converter.dart';

@entity
class ProfileEntity {
  @primaryKey
  final int userId;
  final String tag;
  final String name;
  final String age;
  final String designation;
  final String profileViews;
  final String lastLocation;
  final String pronouns;
  final String location;
  final String bio;
  final String lookingFor;

  @TypeConverters([StringTypeConverter])
  final List<String> about;

  @TypeConverters([StringTypeConverter])
  final List<String> interests;

  @TypeConverters([StringTypeConverter])
  final List<String> profilePics;

  ProfileEntity({
    required this.userId,
    required this.tag,
    required this.name,
    required this.age,
    required this.designation,
    required this.profileViews,
    required this.lastLocation,
    required this.pronouns,
    required this.location,
    required this.bio,
    required this.lookingFor,
    required this.about,
    required this.interests,
    required this.profilePics
  });
}

/**
 * Caching Mechanism that saves profiles
 * - When Swipe with an Action Remove from Database
 * - When asked for profile return the ones with the latest time stamp.
 */
