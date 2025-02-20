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

import '../data/remote/client/my_dio_client.dart' as _i368;
import '../data/repo/auth/authentication_repo_impl.dart' as _i840;
import '../domain/business_logic/repo/auth/authentication_repo.dart' as _i873;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i368.MyDioClient>(() => _i368.MyDioClient(gh<_i361.Dio>()));
    gh.factory<_i873.AuthenticationRepo>(() => _i840.AuthenticationRepoImpl(
          gh<_i368.MyDioClient>(),
          gh<_i930.EncryptedSharedPreferencesAsync>(),
        ));
    return this;
  }
}
