import 'package:glint_frontend/utils/result_sealed.dart';

abstract class ProfileRepo {
  // Get the Data from Db with user id
  Future<Result<void>> fetchUserProfile();

  // Update the profile locally and update the Db
  Future<Result<void>> updateProfileData();

  // User Images upload
  Future<Result<void>> updateMedia();

  // Verify the User but will be in backlog for later
  Future<Result<void>> verifyUser();

  Future<Result<void>> deleteUserMedia(
    List<String> fileNames,
  );
}
