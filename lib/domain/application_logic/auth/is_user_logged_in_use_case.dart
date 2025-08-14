import 'dart:async' show StreamController;
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class IsUserLoggedInUsecase extends UseCase<String?, void> {
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  IsUserLoggedInUsecase(this.sharedPreferenceHelper);

  @override
  Future<Stream<String?>> buildUseCaseStream(void params) async {
    final StreamController<String?> controller = StreamController();
    try {
      final refreshToken =
          await sharedPreferenceHelper.isRefreshTokenAvailable();
      final userType = await sharedPreferenceHelper
          .getString(SharedPreferenceKeys.userRoleKey);
      if (refreshToken != null) {
        controller.add(userType);
      } else {
        controller.add(null);
      }
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

UsersType getUserTypeFromName(String name) {
  return UsersType.values.firstWhere(
    (e) => e.name == name,
    orElse: () => UsersType.USER, // default fallback
  );
}
