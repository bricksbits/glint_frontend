import 'dart:convert' show base64UrlEncode, utf8;
import 'package:crypto/crypto.dart' show sha256;
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/dao/event_like_dao.dart';
import 'package:glint_frontend/data/local/db/dao/membership_dao.dart';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/dao/swipe_action_dao.dart';
import 'package:glint_frontend/data/local/db/database/glint_database.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalModule {
  @lazySingleton
  @preResolve
  Future<GlintDatabase> glintDatabase() => $FloorGlintDatabase
      .databaseBuilder('glint_database.db')
      .addCallback(Callback(onCreate: (db, version) {
        print("DB Created $db with Version $version");
      }, onOpen: (db) {
        print("Db $db is open now");
      }))
      .build();

  @singleton
  ProfileDao getProfileDao(GlintDatabase database) => database.profileDao;

  @singleton
  MembershipDao getMembershipDao(GlintDatabase database) =>
      database.membershipDao;

  @singleton
  EventLikeDao getUserEventLikeDao(GlintDatabase database) =>
      database.eventLikeDao;

  @singleton
  SwipeActionDao getSwipeActionDao(GlintDatabase database) =>
      database.swipeActionDao;

  @preResolve
  Future<EncryptedSharedPreferencesAsync> sharedPref() async {
    const baseKey = "GLINT_PREF";
    final hashedKeyBytes = sha256.convert(utf8.encode(baseKey)).bytes;
    final encryptionKey = base64UrlEncode(hashedKeyBytes.sublist(0, 16));
    await EncryptedSharedPreferencesAsync.initialize("ThisIsASecretKey");
    return EncryptedSharedPreferencesAsync.getInstance();
  }
}
