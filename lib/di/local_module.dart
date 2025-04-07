import 'dart:convert' show base64UrlEncode, utf8;
import 'package:crypto/crypto.dart' show sha256;
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalModule {
  // @lazySingleton
  // @preResolve
  // Future<GlintDatabase> glintDatabase() =>
  //     $FloorGlintDatabase.databaseBuilder('glint_database.db').build();
  //
  // @singleton
  // ProfileDao getProfileDao(GlintDatabase database) => database.profileDao;
  //

  @singleton
  Future<EncryptedSharedPreferencesAsync> sharedPref() async {
    const baseKey = "GLINT_PREF";
    final hashedKeyBytes = sha256.convert(utf8.encode(baseKey)).bytes;
    final encryptionKey = base64UrlEncode(hashedKeyBytes.sublist(0, 16));
    await EncryptedSharedPreferencesAsync.initialize("ThisIsASecretKey");
    return EncryptedSharedPreferencesAsync.getInstance();
  }
}
