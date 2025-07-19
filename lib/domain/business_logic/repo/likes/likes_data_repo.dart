import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class LikesDataRepo {
  Future<Result<int>> getUserProfileViews();

  Future<Result<List<PeopleCardModel>>> getTopProfiles();

  Future<Result<List<PeopleCardModel>>> getSuperLikedProfiles();

  Future<Result<List<PeopleCardModel>>> getLikedProfiles();
}
