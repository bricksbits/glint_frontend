import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';

@dao
abstract class MembershipDao {
  @Query('SELECT * FROM memberships WHERE userId = :userId')
  Future<ProfileMembershipEntity?> getMembership(String userId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMembership(ProfileMembershipEntity membership);
}