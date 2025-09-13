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

  @Query("SELECT * FROM profiles where userId = :passedId")
  Future<ProfileEntity?> getProfileData(String passedId);

  @Query("SELECT * FROM profiles WHERE userId != :currentUserId")
  Future<List<ProfileEntity>> getAllProfiles(String currentUserId);

  @Query("DELETE FROM profiles WHERE userId is :passedId")
  Future<void> deleteAlreadySwipedOnProfile(int passedId);

  @Query("DELETE FROM profiles WHERE userId is :passedId")
  Future<void> deleteOnBoardingProfile(String passedId);

  @Query('DELETE FROM profiles')
  Future<void> clearProfileTable();
}
