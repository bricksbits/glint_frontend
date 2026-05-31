import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as stream;

import 'package:glint_frontend/di/injection.dart';
import 'firebase_test_mocks.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/forgot_password_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/people/people_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_with_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/likes/likes_data_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/notification/notification_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/payment/payment_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/story/story_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/background/info/user_info_repo.dart';

import 'package:glint_frontend/domain/application_logic/auth/is_user_logged_in_use_case.dart';
import 'package:glint_frontend/domain/application_logic/auth/sign_in_user_use_case.dart';
import 'package:glint_frontend/domain/application_logic/logout_usecase.dart';

import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/dao/swipe_action_dao.dart';
import 'package:glint_frontend/data/local/db/dao/event_like_dao.dart';
import 'package:glint_frontend/data/local/db/dao/membership_dao.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';

import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/services/location_permission_service.dart';
import 'package:glint_frontend/services/notification_permission_service.dart';
import 'package:glint_frontend/services/swipe_cache_manager.dart';
import 'package:glint_frontend/services/chat_service.dart';

import 'package:glint_frontend/features/splash/splash_screen_bloc.dart';
import 'package:glint_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:glint_frontend/features/auth/blocs/register/register_cubit.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';
import 'package:glint_frontend/features/chat/base/chat_screen_cubit.dart';
import 'package:glint_frontend/features/event/base/event_base_cubit.dart';
import 'package:glint_frontend/features/payment/payment_cubit.dart';
import 'package:glint_frontend/features/profile/settings_cubit.dart';
import 'package:glint_frontend/features/notifications/notification_cubit.dart';
import 'package:glint_frontend/features/admin/bloc/admin_dasboard/admin_dashboard_bloc.dart';

import 'package:glint_frontend/utils/bootstrap.dart';

// --- Repository Mocks ---
class MockAuthenticationRepo extends Mock implements AuthenticationRepo {}

class MockForgotPasswordRepo extends Mock implements ForgotPasswordRepo {}

class MockOnBoardingRepo extends Mock implements OnBoardingRepo {}

class MockProfileRepo extends Mock implements ProfileRepo {}

class MockPeopleRepo extends Mock implements PeopleRepo {}

class MockChatRepo extends Mock implements ChatRepo {}

class MockChatWithRepo extends Mock implements ChatWithRepo {}

class MockEventRepo extends Mock implements EventRepo {}

class MockLikesDataRepo extends Mock implements LikesDataRepo {}

class MockNotificationRepo extends Mock implements NotificationRepo {}

class MockPaymentRepo extends Mock implements PaymentRepo {}

class MockStoryRepo extends Mock implements StoryRepo {}

class MockAdminDashboardRepo extends Mock implements AdminDashboardRepo {}

class MockUserInfoRepo extends Mock implements UserInfoRepo {}

// --- Service Mocks ---
class MockImageService extends Mock implements ImageService {}

class MockLocationPermissionService extends Mock
    implements LocationPermissionService {}

class MockNotificationPermissionService extends Mock
    implements NotificationPermissionService {}

class MockSwipeBufferManager extends Mock implements SwipeBufferManager {}

class MockChatService extends Mock implements ChatService {}

class MockMyDioClient extends Mock implements MyDioClient {}

// --- Persistence Mocks ---
class MockSharedPreferenceHelper extends Mock
    implements AsyncEncryptedSharedPreferenceHelper {}

class MockEncryptedSharedPreferencesAsync extends Mock
    implements EncryptedSharedPreferencesAsync {}

class MockProfileDao extends Mock implements ProfileDao {}

class MockSwipeActionDao extends Mock implements SwipeActionDao {}

class MockEventLikeDao extends Mock implements EventLikeDao {}

class MockMembershipDao extends Mock implements MembershipDao {}

// --- Use Case Mocks ---
class MockIsUserLoggedInUsecase extends Mock implements IsUserLoggedInUsecase {}

class MockSignInUserUseCase extends Mock implements SignInUserUseCase {}

class MockLogoutUserUsecase extends Mock implements LogoutUserUsecase {}

// --- BLoC / Cubit Mocks ---
class MockSplashScreenBloc extends Mock implements SplashScreenBloc {}

class MockLoginBloc extends Mock implements LoginBloc {}

class MockRegisterCubit extends Mock implements RegisterCubit {}

class MockOnBoardingCubit extends Mock implements OnBoardingCubit {}

class MockPeopleCardsBloc extends Mock implements PeopleCardsBloc {}

class MockChatScreenCubit extends Mock implements ChatScreenCubit {}

class MockEventBaseCubit extends Mock implements EventBaseCubit {}

class MockPaymentCubit extends Mock implements PaymentCubit {}

class MockSettingsCubit extends Mock implements SettingsCubit {}

class MockNotificationCubit extends Mock implements NotificationCubit {}

class MockAdminDashboardBloc extends Mock implements AdminDashboardBloc {}

// --- Helper references for getIt ---
late MockAuthenticationRepo mockAuthRepo;
late MockForgotPasswordRepo mockForgotPasswordRepo;
late MockOnBoardingRepo mockOnBoardingRepo;
late MockProfileRepo mockProfileRepo;
late MockPeopleRepo mockPeopleRepo;
late MockChatRepo mockChatRepo;
late MockChatWithRepo mockChatWithRepo;
late MockEventRepo mockEventRepo;
late MockLikesDataRepo mockLikesDataRepo;
late MockNotificationRepo mockNotificationRepo;
late MockPaymentRepo mockPaymentRepo;
late MockStoryRepo mockStoryRepo;
late MockAdminDashboardRepo mockAdminDashboardRepo;
late MockUserInfoRepo mockUserInfoRepo;

late MockImageService mockImageService;
late MockLocationPermissionService mockLocationPermissionService;
late MockNotificationPermissionService mockNotificationPermissionService;
late MockSwipeBufferManager mockSwipeBufferManager;
late MockChatService mockChatService;
late MockMyDioClient mockDioClient;

late MockSharedPreferenceHelper mockSharedPrefs;
late MockProfileDao mockProfileDao;
late MockSwipeActionDao mockSwipeActionDao;
late MockEventLikeDao mockEventLikeDao;
late MockMembershipDao mockMembershipDao;

late MockIsUserLoggedInUsecase mockIsUserLoggedInUsecase;
late MockSignInUserUseCase mockSignInUserUseCase;
late MockLogoutUserUsecase mockLogoutUserUsecase;

Future<void> registerTestDependencies() async {
  await setupFirebaseTestMocks();
  await getIt.reset();

  // Repositories
  mockAuthRepo = MockAuthenticationRepo();
  mockForgotPasswordRepo = MockForgotPasswordRepo();
  mockOnBoardingRepo = MockOnBoardingRepo();
  mockProfileRepo = MockProfileRepo();
  mockPeopleRepo = MockPeopleRepo();
  mockChatRepo = MockChatRepo();
  mockChatWithRepo = MockChatWithRepo();
  mockEventRepo = MockEventRepo();
  mockLikesDataRepo = MockLikesDataRepo();
  mockNotificationRepo = MockNotificationRepo();
  mockPaymentRepo = MockPaymentRepo();
  mockStoryRepo = MockStoryRepo();
  mockAdminDashboardRepo = MockAdminDashboardRepo();
  mockUserInfoRepo = MockUserInfoRepo();

  getIt.registerSingleton<AuthenticationRepo>(mockAuthRepo);
  getIt.registerSingleton<ForgotPasswordRepo>(mockForgotPasswordRepo);
  getIt.registerSingleton<OnBoardingRepo>(mockOnBoardingRepo);
  getIt.registerSingleton<ProfileRepo>(mockProfileRepo);
  getIt.registerSingleton<PeopleRepo>(mockPeopleRepo);
  getIt.registerSingleton<ChatRepo>(mockChatRepo);
  getIt.registerSingleton<ChatWithRepo>(mockChatWithRepo);
  getIt.registerSingleton<EventRepo>(mockEventRepo);
  getIt.registerSingleton<LikesDataRepo>(mockLikesDataRepo);
  getIt.registerSingleton<NotificationRepo>(mockNotificationRepo);
  getIt.registerSingleton<PaymentRepo>(mockPaymentRepo);
  getIt.registerSingleton<StoryRepo>(mockStoryRepo);
  getIt.registerSingleton<AdminDashboardRepo>(mockAdminDashboardRepo);
  getIt.registerSingleton<UserInfoRepo>(mockUserInfoRepo);

  // Services
  mockImageService = MockImageService();
  mockLocationPermissionService = MockLocationPermissionService();
  mockNotificationPermissionService = MockNotificationPermissionService();
  mockSwipeBufferManager = MockSwipeBufferManager();
  mockChatService = MockChatService();
  mockDioClient = MockMyDioClient();

  getIt.registerSingleton<ImageService>(mockImageService);
  getIt.registerSingleton<LocationPermissionService>(
      mockLocationPermissionService);
  getIt.registerSingleton<NotificationPermissionService>(
      mockNotificationPermissionService);
  getIt.registerSingleton<SwipeBufferManager>(mockSwipeBufferManager);
  getIt.registerSingleton<ChatService>(mockChatService);
  getIt.registerSingleton<MyDioClient>(mockDioClient);

  // Persistence
  mockSharedPrefs = MockSharedPreferenceHelper();
  mockProfileDao = MockProfileDao();
  mockSwipeActionDao = MockSwipeActionDao();
  mockEventLikeDao = MockEventLikeDao();
  mockMembershipDao = MockMembershipDao();

  getIt.registerSingleton<AsyncEncryptedSharedPreferenceHelper>(
      mockSharedPrefs);
  getIt.registerSingleton<ProfileDao>(mockProfileDao);
  getIt.registerSingleton<SwipeActionDao>(mockSwipeActionDao);
  getIt.registerSingleton<EventLikeDao>(mockEventLikeDao);
  getIt.registerSingleton<MembershipDao>(mockMembershipDao);

  // Use Cases
  mockIsUserLoggedInUsecase = MockIsUserLoggedInUsecase();
  mockSignInUserUseCase = MockSignInUserUseCase();
  mockLogoutUserUsecase = MockLogoutUserUsecase();

  getIt.registerSingleton<IsUserLoggedInUsecase>(mockIsUserLoggedInUsecase);
  getIt.registerSingleton<SignInUserUseCase>(mockSignInUserUseCase);
  getIt.registerSingleton<LogoutUserUsecase>(mockLogoutUserUsecase);
}
