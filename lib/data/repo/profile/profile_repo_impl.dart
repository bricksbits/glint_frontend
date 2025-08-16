import 'package:glint_frontend/data/local/db/dao/membership_dao.dart';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final ProfileDao profileDao;
  final MembershipDao membershipDao;

  ProfileRepoImpl({
    required this.httpClient,
    required this.sharedPreferenceHelper,
    required this.profileDao,
    required this.membershipDao,
  });

  @override
  Future<Result<PeopleCardModel>> fetchUserProfile() async {
    var getCurrentUserid =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    var currentUser = await profileDao.getProfileData(getCurrentUserid);
    if (currentUser != null) {
      return Success(currentUser.mapToPeopleUiModel());
    } else {
      return Failure(Exception("Error: User doesn't exists, login again"));
    }
  }

  @override
  Future<Result<void>> getAllPaymentHistory() {
    // TODO: implement getAllPaymentHistory
    throw UnimplementedError();
  }

  @override
  Future<int> getProfileProgress() {
    // TODO: implement getProfileProgress
    throw UnimplementedError();
  }

  @override
  Future<Result<ProfileMembershipEntity>> getUserMembershipDetails() async {
    var getCurrentUserid =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    final membershipEntity =
        await membershipDao.getMembership(getCurrentUserid);
    if (membershipEntity != null) {
      return Success(membershipEntity);
    } else {
      return Failure(Exception("Error: No membership data Found"));
    }
  }

  @override
  Future<Result<void>> updateMedia() {
    // TODO: implement updateMedia
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updateProfileData() {
    // TODO: implement updateProfileData
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> verifyUser() {
    // TODO: implement verifyUser
    throw UnimplementedError();
  }
}
