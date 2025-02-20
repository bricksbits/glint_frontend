import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/database/glint_database.dart';
import 'package:injectable/injectable.dart';

abstract class LocalModule {

  @lazySingleton
  @preResolve
  Future<GlintDatabase> glintDatabase() => $FloorGlintDatabase.databaseBuilder('glint_database.db').build();

  @singleton
  ProfileDao getProfileDao(GlintDatabase database) => database.profileDao;
}