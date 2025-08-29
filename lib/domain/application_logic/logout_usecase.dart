import 'dart:async';

import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LogoutUserUsecase extends UseCase<bool, void> {
  final AsyncEncryptedSharedPreferenceHelper
      asyncEncryptedSharedPreferenceHelper;
  final ProfileDao dao;

  LogoutUserUsecase(
      {required this.asyncEncryptedSharedPreferenceHelper, required this.dao});

  @override
  Future<Stream<bool>> buildUseCaseStream(void params) async {
    final StreamController<bool> controller = StreamController();
    try {
      await asyncEncryptedSharedPreferenceHelper.clearEncryptedPrefs();
      await dao.clearProfileTable();
      controller.add(true);
    } catch (e) {
      controller.addError(Exception(e.toString()));
      controller.close();
    }

    return controller.stream;
  }
}
