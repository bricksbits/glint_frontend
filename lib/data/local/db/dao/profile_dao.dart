import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';

@dao
abstract class ProfileDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProfile(ProfileEntity profile);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateProfileData(ProfileEntity updatedProfile);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFetchedProfiles(List<ProfileEntity> profiles);

  @Query("SELECT * FROM ProfileEntity where userId = :passedId")
  Future<ProfileEntity?> getProfileData(String passedId);

  @Query("DELETE FROM ProfileEntity WHERE userId is (:passedId)")
  Future<void> deleteAlreadySwipedOnProfile(int passedId);
}
