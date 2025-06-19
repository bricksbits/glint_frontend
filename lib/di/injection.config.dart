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
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as _i981;

import '../data/local/db/dao/profile_dao.dart' as _i719;
import '../data/local/db/dao/swipe_action_dao.dart' as _i1004;
import '../data/local/db/database/glint_database.dart' as _i160;
import '../data/local/persist/async_encrypted_shared_preference_helper.dart'
    as _i274;
import '../data/local/swipe_cache_manager.dart' as _i350;
import '../data/remote/client/my_dio_client.dart' as _i368;
import '../data/repo/admin/admin_dash_board_repo_impl.dart' as _i72;
import '../data/repo/auth/authentication_repo_impl.dart' as _i840;
import '../data/repo/auth/forgot_password_repo_impl.dart' as _i509;
import '../data/repo/chat/chat_main/chat_repo_impl.dart' as _i651;
import '../data/repo/onBoard/on_boarding_repo_impl.dart' as _i359;
import '../data/repo/payment/payment_repo_impl.dart' as _i854;
import '../data/repo/people/people_repo_impl.dart' as _i955;
import '../data/repo/story/story_repo_impl.dart' as _i946;
import '../domain/application_logic/admin/approve_published_event_usecase.dart'
    as _i839;
import '../domain/application_logic/admin/get_all_events_use_case.dart'
    as _i1027;
import '../domain/application_logic/admin/reject_published_event_usecase.dart'
    as _i579;
import '../domain/application_logic/auth/is_user_logged_in_use_case.dart'
    as _i143;
import '../domain/application_logic/auth/sign_in_user_use_case.dart' as _i972;
import '../domain/business_logic/repo/admin/admin_dasboard_repo.dart' as _i1000;
import '../domain/business_logic/repo/auth/authentication_repo.dart' as _i873;
import '../domain/business_logic/repo/auth/forgot_password_repo.dart' as _i995;
import '../domain/business_logic/repo/boarding/on_boarding_repo.dart' as _i330;
import '../domain/business_logic/repo/chat/chat_repo.dart' as _i849;
import '../domain/business_logic/repo/payment/payment_repo.dart' as _i235;
import '../domain/business_logic/repo/people/people_repo.dart' as _i678;
import '../domain/business_logic/repo/story/story_repo.dart' as _i762;
import '../services/image_manager_service.dart' as _i43;
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
    final localModule = _$LocalModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i930.EncryptedSharedPreferencesAsync>(
      () => localModule.sharedPref(),
      preResolve: true,
    );
    gh.factory<_i43.ImageService>(() => _i43.ImageService());
    gh.singleton<_i361.Dio>(() => networkModule.getHttpClientInstance());
    gh.singleton<_i981.StreamChatClient>(() => networkModule.chatClient());
    await gh.lazySingletonAsync<_i160.GlintDatabase>(
      () => localModule.glintDatabase(),
      preResolve: true,
    );
    gh.singleton<_i719.ProfileDao>(
        () => localModule.getProfileDao(gh<_i160.GlintDatabase>()));
    gh.singleton<_i1004.SwipeActionDao>(
        () => localModule.getSwipeActionDao(gh<_i160.GlintDatabase>()));
    gh.lazySingleton<_i274.AsyncEncryptedSharedPreferenceHelper>(() =>
        _i274.AsyncEncryptedSharedPreferenceHelper(
            gh<_i930.EncryptedSharedPreferencesAsync>()));
    gh.factory<_i368.MyDioClient>(() => _i368.MyDioClient(
          gh<_i361.Dio>(),
          gh<_i274.AsyncEncryptedSharedPreferenceHelper>(),
        ));
    gh.singleton<_i350.SwipeBufferManager>(() => _i350.SwipeBufferManager(
          gh<_i368.MyDioClient>(),
          profileDao: gh<_i719.ProfileDao>(),
          swipeActionDao: gh<_i1004.SwipeActionDao>(),
        ));
    gh.factory<_i330.OnBoardingRepo>(() => _i359.OnBoardRepoImpl(
          gh<_i719.ProfileDao>(),
          gh<_i274.AsyncEncryptedSharedPreferenceHelper>(),
          gh<_i368.MyDioClient>(),
        ));
    gh.factory<_i995.ForgotPasswordRepo>(
        () => _i509.ForgotPasswordRepoImpl(gh<_i368.MyDioClient>()));
    gh.lazySingleton<_i143.IsUserLoggedInUsecase>(() =>
        _i143.IsUserLoggedInUsecase(
            gh<_i274.AsyncEncryptedSharedPreferenceHelper>()));
    gh.lazySingleton<_i873.AuthenticationRepo>(
        () => _i840.AuthenticationRepoImpl(
              gh<_i368.MyDioClient>(),
              gh<_i274.AsyncEncryptedSharedPreferenceHelper>(),
              gh<_i719.ProfileDao>(),
            ));
    gh.factory<_i972.SignInUserUseCase>(
        () => _i972.SignInUserUseCase(gh<_i873.AuthenticationRepo>()));
    gh.factory<_i235.PaymentRepo>(
        () => _i854.PaymentRepoImpl(gh<_i368.MyDioClient>()));
    gh.factory<_i762.StoryRepo>(() => _i946.StoryRepoImpl(
          gh<_i368.MyDioClient>(),
          gh<_i274.AsyncEncryptedSharedPreferenceHelper>(),
        ));
    gh.factory<_i1000.AdminDashboardRepo>(
        () => _i72.AdminDashBoardRepoImpl(gh<_i368.MyDioClient>()));
    gh.lazySingleton<_i678.PeopleRepo>(() => _i955.PeopleRepoImpl(
          gh<_i368.MyDioClient>(),
          gh<_i274.AsyncEncryptedSharedPreferenceHelper>(),
          gh<_i719.ProfileDao>(),
        ));
    gh.factory<_i849.ChatRepo>(
        () => _i651.ChatRepoImpl(gh<_i368.MyDioClient>()));
    gh.factory<_i579.RejectPublishedEventUsecase>(() =>
        _i579.RejectPublishedEventUsecase(gh<_i1000.AdminDashboardRepo>()));
    gh.factory<_i839.ApprovePublishedEventUsecase>(() =>
        _i839.ApprovePublishedEventUsecase(gh<_i1000.AdminDashboardRepo>()));
    gh.factory<_i1027.GetAllEventsUsecase>(
        () => _i1027.GetAllEventsUsecase(gh<_i1000.AdminDashboardRepo>()));
    return this;
  }
}

class _$LocalModule extends _i519.LocalModule {}

class _$NetworkModule extends _i567.NetworkModule {}
