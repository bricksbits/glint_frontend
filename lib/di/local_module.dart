import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/database/glint_database.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalModule {
  @lazySingleton
  @preResolve
  Future<GlintDatabase> glintDatabase() =>
      $FloorGlintDatabase.databaseBuilder('glint_database.db').build();

  @singleton
  ProfileDao getProfileDao(GlintDatabase database) => database.profileDao;

  @singleton
  @preResolve
  Future<EncryptedSharedPreferencesAsync> sharedPref() async {
    const key = "";
    await EncryptedSharedPreferencesAsync.initialize(key);
    return EncryptedSharedPreferencesAsync.getInstance();
  }
}
