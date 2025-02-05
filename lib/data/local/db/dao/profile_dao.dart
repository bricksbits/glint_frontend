import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';

@dao
abstract class ProfileDao {
  @insert
  Future<void> insertProfileData(ProfileEntity profile);
}