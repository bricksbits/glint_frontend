import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class ProfileRepo {
  Future<Result<PeopleCardModel>> fetchUserProfile();

  Future<Result<void>> updateProfileData();

  Future<Result<void>> updateMedia();

  Future<Result<void>> verifyUser();

  Future<int> getProfileProgress();

  Future<Result<ProfileMembershipEntity>> getUserMembershipDetails();

  Future<Result<void>> getAllPaymentHistory();
}
