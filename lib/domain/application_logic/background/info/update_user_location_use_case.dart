import 'package:glint_frontend/domain/business_logic/repo/background/info/user_info_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';

class UpdateUserLocationUseCase extends UseCase<void,String>{
  final UserInfoRepo userInfoRepo;

  UpdateUserLocationUseCase(this.userInfoRepo);

  @override
  Future<Stream<void>> buildUseCaseStream(String? params) {
    // TODO: implement buildUseCaseStream
    throw UnimplementedError();
  }
}