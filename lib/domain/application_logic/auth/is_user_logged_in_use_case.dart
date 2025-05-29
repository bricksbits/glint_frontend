import 'dart:async' show StreamController;
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class IsUserLoggedInUsecase extends UseCase<bool,void> {
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  IsUserLoggedInUsecase(this.sharedPreferenceHelper);

  @override
  Future<Stream<bool?>> buildUseCaseStream(void params) async {
    final StreamController<bool> controller = StreamController();
    try {
      final refreshToken = await sharedPreferenceHelper.isRefreshTokenAvailable();
      controller.add(refreshToken != null && refreshToken.isNotEmpty);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}
