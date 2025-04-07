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

import '../data/local/persist/async_encrypted_shared_preference_helper.dart'
    as _i274;
import '../data/remote/client/my_dio_client.dart' as _i368;
import '../data/remote/utils/access_token_helper.dart' as _i684;
import '../data/repo/admin/admin_dash_board_repo_impl.dart' as _i72;
import '../data/repo/auth/authentication_repo_impl.dart' as _i840;
import '../data/repo/auth/forgot_password_repo_impl.dart' as _i509;
import '../domain/application_logic/auth/sign_in_user_use_case.dart' as _i972;
import '../domain/business_logic/repo/admin/admin_dasboard_repo.dart' as _i1000;
import '../domain/business_logic/repo/auth/authentication_repo.dart' as _i873;
import '../domain/business_logic/repo/auth/forgot_password_repo.dart' as _i995;
import 'local_module.dart' as _i519;
import 'network_module.dart' as _i567;

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
    final localModule = _$LocalModule();
    final networkModule = _$NetworkModule();
    gh.singletonAsync<_i930.EncryptedSharedPreferencesAsync>(
        () => localModule.sharedPref());
    gh.singleton<_i361.Dio>(() => networkModule.getHttpClientInstance());
    gh.factoryAsync<_i274.AsyncEncryptedSharedPreferenceHelper>(() async =>
        _i274.AsyncEncryptedSharedPreferenceHelper(
            await getAsync<_i930.EncryptedSharedPreferencesAsync>()));
    gh.factory<_i368.MyDioClient>(() => _i368.MyDioClient(gh<_i361.Dio>()));
    gh.factoryAsync<_i684.AccessTokenHelper>(
        () async => _i684.AccessTokenHelper(
              await getAsync<_i274.AsyncEncryptedSharedPreferenceHelper>(),
              gh<_i368.MyDioClient>(),
            ));
    gh.factoryAsync<_i995.ForgotPasswordRepo>(
        () async => _i509.ForgotPasswordRepoImpl(
              gh<_i368.MyDioClient>(),
              await getAsync<_i274.AsyncEncryptedSharedPreferenceHelper>(),
            ));
    gh.lazySingletonAsync<_i873.AuthenticationRepo>(
        () async => _i840.AuthenticationRepoImpl(
              gh<_i368.MyDioClient>(),
              await getAsync<_i274.AsyncEncryptedSharedPreferenceHelper>(),
            ));
    gh.factoryAsync<_i1000.AdminDashboardRepo>(
        () async => _i72.AdminDashBoardRepoImpl(
              gh<_i368.MyDioClient>(),
              await getAsync<_i274.AsyncEncryptedSharedPreferenceHelper>(),
            ));
    gh.factoryAsync<_i972.SignInUserUseCase>(() async =>
        _i972.SignInUserUseCase(await getAsync<_i873.AuthenticationRepo>()));
    return this;
  }
}

class _$LocalModule extends _i519.LocalModule {}

class _$NetworkModule extends _i567.NetworkModule {}
