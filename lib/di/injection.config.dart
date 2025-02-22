// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:encrypt_shared_preferences/provider.dart' as _i930;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/local/db/dao/profile_dao.dart' as _i719;
import '../data/local/db/database/glint_database.dart' as _i160;
import '../data/remote/client/my_dio_client.dart' as _i368;
import '../data/repo/auth/authentication_repo_impl.dart' as _i840;
import '../domain/business_logic/repo/auth/authentication_repo.dart' as _i873;
import 'local_module.dart' as _i519;
import 'network_module.dart' as _i567;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    final localModule = _$LocalModule();
    gh.singleton<_i361.Dio>(() => networkModule.getHttpClientInstance());
    await gh.lazySingletonAsync<_i160.GlintDatabase>(
      () => localModule.glintDatabase(),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i930.EncryptedSharedPreferencesAsync>(
      () => localModule.sharedPref(),
      preResolve: true,
    );
    gh.singleton<_i719.ProfileDao>(
        () => localModule.getProfileDao(gh<_i160.GlintDatabase>()));
    gh.factory<_i368.MyDioClient>(() => _i368.MyDioClient(gh<_i361.Dio>()));
    gh.factory<_i873.AuthenticationRepo>(() => _i840.AuthenticationRepoImpl(
          gh<_i368.MyDioClient>(),
          gh<_i930.EncryptedSharedPreferencesAsync>(),
        ));
    return this;
  }
}

class _$NetworkModule extends _i567.NetworkModule {}

class _$LocalModule extends _i519.LocalModule {}
