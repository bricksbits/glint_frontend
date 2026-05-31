# Glint Frontend — Test Strategy & Execution Handoff

> This document is self-contained. Sonnet CLI should need zero context beyond this file and the codebase to implement every test.

---

## Section 1: Project Map

### 1.1 Navigation Tree

```
/ (splash)
  SplashScreen → determines user type → routes to:
    ├─ /starter (StarterScreen) — not logged in
    ├─ /home (HomeScreen) — USER
    ├─ /adminHome (AdminDashboardScreen) — ADMIN
    └─ /superAdminHome (SuperAdminDashboardScreen) — SUPER_ADMIN

/starter (StarterScreen)
  ├─ "Create Account" → /boarding (onboarding shell)
  ├─ "Create Admin Account" → /register (extra: true)
  └─ "Login" → /auth (LoginScreen)

/auth (LoginScreen, isAdmin: false)
  ├─ success(USER) → /home
  ├─ success(ADMIN) → /adminHome
  ├─ success(SUPER_ADMIN) → /superAdminHome
  ├─ "Forgot your password?" → /resetPassword
  └─ "Create now" → /starter

/resetPassword (ShellRoute, ResetPasswordBloc)
  ├─ /resetPassword → ResetPasswordScreen
  ├─ /otp/:email → EnterOtpScreen
  ├─ /recreatePassword → CreatePasswordScreen
  └─ /passwordSuccess → PasswordChangeConfirmationScreen → /auth

/onBoarding (ShellRoute, OnBoardingCubit)
  ├─ /boarding → SetupGlintOnboardingScreen
  ├─ /name → EnterNameOnboardingScreen
  ├─ /dob → DateOfBirthOnboardingScreen
  ├─ /gender → IdentifyYourselfOnboardingScreen
  ├─ /interestedGender → WhoCatchesYourEyeOnboardingScreen
  ├─ /media → UploadPhotosOnboardingScreen
  ├─ /pronouns → GetSetGlintOnboardingScreen
  ├─ /interests → InterestsAndVibeOnboardingScreen
  ├─ /bio → OneLastStepOnboardingScreen
  └─ /location → LocationPermissionOnboardingScreen → /register (extra: false)

/register (CreateAccounScreen, RegisterCubit)
  ├─ user flow: email + password + confirm → register → login → upload images → /home
  └─ admin flow: name + email + org + contact + password → register → login → /adminHome

/home (HomeScreen) — 4 bottom-nav tabs:
  ├─ Tab 0: ProfileScreen (/profile)
  ├─ Tab 1: EventBaseScreen (/event)
  ├─ Tab 2: PeopleScreen (/people) — DEFAULT
  └─ Tab 3: ChatScreen (/chat)

/chat (parent)
  ├─ /chatWith → ChatWithScreen (args: ChatWithNavArguments)
  ├─ /stories → ViewStoryScreen (args: index + stories list)
  ├─ /uploadStory → UploadStoryScreen
  ├─ /getTicket → GetEventTicketScreen
  ├─ /videoCall → ChatWithVideoCallScreen
  └─ /oneTimePhotoView → OneTimeViewScreen

/event (parent)
  ├─ /eventDetails → EventDetailScreen (args: eventId)
  ├─ /peopleInterested → PeopleInterestedForEventScreen
  └─ /tickets → EventTicketHistoryScreen

/profile (parent)
  ├─ /profilePreview → ProfilePreviewScreen
  ├─ /editProfile → EditProfileScreen
  └─ /paymentHistory → PaymentHistoryScreen

/settings → ProfileSettingsScreen (SettingsCubit)
/notifications → NotificationScreen (NotificationCubit)
/likes → LikesScreen (LikesScreenCubit)
/filter → FilterPreferenceScreen (FilterPreferencesCubit)
/payment → PaymentScreen (PaymentCubit, args: PaymentArgumentModel)
/confirmTicket → ConfirmTicketScreen (ConfirmTicketCubit)
/service → ServiceScreen (placeholder)

/adminHome (ShellRoute, AdminDashboardBloc)
  ├─ /adminHome → AdminDashboardScreen
  ├─ /adminPublishedEvents → AdminTrackEventScreen
  └─ /authProfile → AdminEditProfileScreen

/trackEvent (ShellRoute, TrackAdminEventCubit)
  ├─ /trackEvent → AdminTrackSpecificEvent
  ├─ /interestedUsers → TrackEventInterestedPeopleScreen
  └─ /ticketBought → TrackEventTicketsBoughtScreen

/createEvent → AdminCreateEventScreen (AdminCreateEventCubit)
/liveEvent → AdminEventLiveScreen
/previewEvent → EventDetailScreen (admin preview)
/superAdminHome → SuperAdminDashboardScreen (SuperAdminDashboardBloc)
```

### 1.2 User Types and Access

| Type | Enum | Login Route | Home Screen | Access |
|------|------|-------------|-------------|--------|
| Normal User | `UsersType.USER` | `/home` | HomeScreen (4 tabs) | People, Chat, Events, Profile, Likes, Notifications, Filter, Payment, Settings |
| Admin | `UsersType.ADMIN` | `/adminHome` | AdminDashboardScreen | Create Event, Track Event, Published Events, Edit Profile |
| Super Admin | `UsersType.SUPER_ADMIN` | `/superAdminHome` | SuperAdminDashboardScreen | Approve/Reject Events, View Live & Requested Events |

### 1.3 Key Services and Dependencies

| Service | Class | Registration | Role |
|---------|-------|-------------|------|
| HTTP Client | `MyDioClient` | Singleton | All API calls via Dio |
| Auth Token Interceptor | `AuthTokenInterceptor` | Singleton | Injects auth/refresh tokens into requests |
| Stream Chat | `StreamChatClient` | via `NetworkModule` | Real-time messaging, stories |
| Image Service | `ImageService` | Singleton | Image picking, compression, storage |
| Swipe Buffer | `SwipeBufferManager` | Singleton | Batches swipe actions |
| Location Permission | `LocationPermissionService` | Singleton | Geolocator permission + position |
| Notification Permission | `NotificationPermissionService` | Singleton | Push notification permission |
| Analytics | `GlintAnalyticService` | Static | Firebase Analytics events |
| Encrypted SharedPrefs | `AsyncEncryptedSharedPreferenceHelper` | Singleton | Token storage, user prefs |
| Floor Database | `GlintDatabase` | Singleton | Local SQLite (profiles, swipes, events) |
| Payment | `PaymentCubit` | Global BLoC | Razorpay integration |
| User Info Manager | `UserInfoManagerCubit` | Global BLoC | Membership data, FCM setup, location updates |
| Internet Checker | `InternetStatusCheckerCubit` | Global BLoC | Connectivity monitoring |

---

## Section 2: Test Environment Setup

### 2.1 Required Test Dependencies

Add to `pubspec.yaml` under `dev_dependencies` if missing:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  bloc_test: ^9.1.0
  mocktail: ^1.0.4
  fake_async: ^1.3.1
```

Run after modifying: `fvm flutter pub get`

### 2.2 Mock Setup Instructions

The following services MUST be mocked for all tests. Every service is accessed via `getIt` (GetIt service locator), so mocks must be registered before any widget or cubit under test is created.

#### Services to Mock

| Service Interface | Implementation | Why Mock |
|-------------------|---------------|----------|
| `AuthenticationRepo` | `AuthenticationRepoImpl` | Network calls |
| `ForgotPasswordRepo` | `ForgotPasswordRepoImpl` | Network calls |
| `OnBoardingRepo` | `OnBoardingRepoImpl` | Local DB + network |
| `ProfileRepo` | `ProfileRepoImpl` | Network calls |
| `PeopleRepo` | `PeopleRepoImpl` | Network calls |
| `ChatRepo` | `ChatRepoImpl` | Stream Chat SDK |
| `ChatWithRepo` | `ChatWithRepoImpl` | Stream Chat SDK |
| `EventsRepo` | `EventsRepoImpl` | Network calls |
| `LikesDataRepo` | `LikesDataRepoImpl` | Network calls |
| `NotificationRepo` | `NotificationRepoImpl` | Network calls |
| `PaymentRepo` | `PaymentRepoImpl` | Razorpay + network |
| `StoryRepo` | `StoryRepoImpl` | Network calls |
| `AdminDashboardRepo` | `AdminDashBoardRepoImpl` | Network calls |
| `UserInfoRepo` | `UserInfoRepoImpl` | Network calls |
| `MyDioClient` | — | HTTP layer |
| `AsyncEncryptedSharedPreferenceHelper` | — | Encrypted prefs |
| `GlintDatabase` | — | Floor SQLite |
| `ProfileDao` | — | Floor DAO |
| `SwipeActionDao` | — | Floor DAO |
| `EventLikeDao` | — | Floor DAO |
| `MembershipDao` | — | Floor DAO |
| `ImageService` | — | File I/O |
| `LocationPermissionService` | — | Device permission |
| `NotificationPermissionService` | — | Device permission |
| `SwipeBufferManager` | — | Swipe batching |
| `StreamChatClient` | — | Stream SDK |

#### Mock Registration Pattern

```dart
// In test/helpers/mock_services.dart
// For each service:
class MockAuthenticationRepo extends Mock implements AuthenticationRepo {}
// ... repeat for all services above

void registerTestDependencies() {
  // Reset getIt before each test
  getIt.reset();

  // Register all mocks
  getIt.registerSingleton<AuthenticationRepo>(MockAuthenticationRepo());
  getIt.registerSingleton<OnBoardingRepo>(MockOnBoardingRepo());
  // ... etc for every service listed above

  // Register use cases that depend on repos
  getIt.registerSingleton<IsUserLoggedInUsecase>(
    IsUserLoggedInUsecase(getIt.get<AsyncEncryptedSharedPreferenceHelper>()),
  );
  getIt.registerSingleton<SignInUserUseCase>(
    SignInUserUseCase(
      getIt.get<AuthenticationRepo>(),
      getIt.get<ProfileRepo>(),
    ),
  );
  // ... etc for all use cases
}
```

### 2.3 Test Credentials

**For Onboarding / Registration flows:**
Generate random credentials per test run:
```dart
// In test/helpers/test_credentials.dart
import 'dart:math';

class TestCredentials {
  static String generateEmail() {
    final random = Random().nextInt(99999);
    return 'testuser$random@glinttest.io';
  }

  static String generatePassword() {
    return 'TestPass${Random().nextInt(99999)}!';
  }
}
```

**For Login flows (reuse across all login tests):**
```
email:    Batman@glintapp.io
password: 1234567890

or 

email:    Flash@glintapp.io
password: 1234567890

or 

email:    catwoman@glintapp.io
password: 1234567890
```

---

## Section 3: E2E Test Specs (40% of total coverage)

### Flow 1: Normal User Onboarding → Profile → Buy Membership

**Precondition:** App launched fresh (no auth tokens stored). All mocked services return success responses.

| Step | Action | Widget/Route | Verification |
|------|--------|-------------|-------------|
| 1 | App launches | Route `/` (SplashScreen) | Lottie animation plays; `SplashScreenBloc` emits `navigateTo('starter')` because no refresh token exists |
| 2 | Splash completes | Route `/starter` (StarterScreen) | Find text `'Ready to Glint'`; find 3 buttons: `'Create Account'`, `'Create Admin Account'`, `'Login'` |
| 3 | Tap "Create Account" | Route `/boarding` (SetupGlintOnboardingScreen) | Find text `'Setup your'` and `'Glint'`; find `GlintElevatedButton` with label `'Next'` |
| 4 | Tap "Next" | Route `/name` (EnterNameOnboardingScreen) | Find a `TextField` for name input |
| 5 | Enter name "TestUser" | OnBoardingCubit.setName("TestUser") | State updated: `currentState.username == "TestUser"` |
| 6 | Tap "Next" | Route `/dob` (DateOfBirthOnboardingScreen) | Find `BottomPicker` or date selection widget |
| 7 | Select DOB (age >= 18) | OnBoardingCubit.setAge() | State updated: `currentState.calculatedAge >= "18"` |
| 8 | Tap "Next" | Route `/gender` (IdentifyYourselfOnboardingScreen) | Find text `'Identify Yourself?'`; find 2 `GlintCustomIconChip`: `"I'm Female"`, `"I'm Male"` |
| 9 | Tap "I'm Female" | Sets `selectedIdentity = 'Woman'`, calls `setGender("Female")` | Chip `"I'm Female"` shows selected state (`isSelected: true`) |
| 10 | Tap "Next" | Route `/interestedGender` (WhoCatchesYourEyeOnboardingScreen) | Find text `'Who Catches'` and `'Your eye?'`; find 2 chips: `'Woman'`, `'Man'` |
| 11 | Tap "Man" | Sets `selectedGender = 'Man'`, calls `setGenderPreferences("Male")` | Chip `'Man'` shows selected state |
| 12 | Tap "Next" | Route `/media` (UploadPhotosOnboardingScreen) | Find upload photo grid (9 slots), first labeled "DP" |
| 13 | Mock image pick | OnBoardingCubit.onPickImage() returns mock File | `state.uploadedFilePaths.length >= 1`; image preview shown in grid slot |
| 14 | Tap "Next" | Route `/pronouns` (GetSetGlintOnboardingScreen) | Find text `'Get, Set,'` and `'Glint'`; find `ImLookingForCard` with 4 options |
| 15 | Select "Something Casual" | OnBoardingCubit.setLookingFor("Something Casual") | `state.currentState.relationShipGoals == "Something Casual"` |
| 16 | Tap "Next" | Route `/interests` (InterestsAndVibeOnboardingScreen) | Find text `'Your Interests, Your Vibe'`; find `InterestAndVibeSelection` grid |
| 17 | Select 5 interests | Tap 5 `GlintEmojiSelectionChip` widgets | `state.currentState.interests.length == 5` |
| 18 | Tap "Next" | Route `/bio` (OneLastStepOnboardingScreen) | Find text `'One Last'` and `'Step'`; find `EnterYourBio` + `AdditionalInfoContainer` |
| 19 | Enter bio "I love hiking" | OnBoardingCubit.setBio("I love hiking") | `state.currentState.bio == "I love hiking"` |
| 20 | Fill occupation "Engineer" | Tap occupation field → bottom sheet → enter text | `state.currentState.occupation == "Engineer"` |
| 21 | Select education "bachelors" | Tap education field → bottom sheet → select chip | `state.currentState.education == "bachelors"` |
| 22 | Set height via slider | Drag `HeightInputComponent` slider | `state.currentState.height != null` |
| 23 | Select workout "sometimes" | Tap workout field → bottom sheet → select chip | `state.currentState.workoutHabit == "sometimes"` |
| 24 | Select drinking "occasionally" | Tap drinking field → bottom sheet → select chip | `state.currentState.drinkingHabit == "occasionally"` |
| 25 | Select smoking "nonSmoker" | Tap smoking field → bottom sheet → select chip | `state.currentState.smokingHabit == "nonSmoker"` |
| 26 | Tap "Next" | Route `/location` (LocationPermissionOnboardingScreen) | Find text `"See Who's Close to You!"`; find 2 `PermissionButton` widgets |
| 27 | Tap "Enable Notifications" | Calls `NotificationPermissionService.requestPermission()` | Button state changes to `PermissionButtonState.granted` |
| 28 | Tap "Enable Location" | Calls `OnBoardingCubit.enableLocationAndCompleteOnboarding()` | `state.onBoardingStatus == OnBoardingCompletedTill.COMPLETED`; `PermissionButton` shows granted |
| 29 | Auto-navigates | Route `/register` (CreateAccounScreen, `isAdmin: false`) | Find `AuthIconTextField` for email and password; find `'Sign up'` button |
| 30 | Enter email (random) | RegisterCubit.enteredEmail() | `state.email` is non-empty |
| 31 | Enter password (>= 10 chars) | RegisterCubit.enteredPassword() | `state.password.length >= 10` |
| 32 | Enter confirm password | RegisterCubit.enteredConfirmPassword() | `state.confirmPassword == state.password` |
| 33 | Tap "Sign up" | RegisterCubit.registerUser() | Loading indicator shown with `state.currentSuccessStatus`; mock returns Success |
| 34 | Registration succeeds | Auto-login + upload media | State: `isRegisteredSuccessfully == true`, `navigateToRoute == 'home'` |
| 35 | Navigate to home | Route `/home` (HomeScreen) | Bottom nav bar visible with 4 icons; `PeopleScreen` active (default tab index 2) |
| 36 | Tap Profile tab (index 0) | HomeScreen._selectedIndex = 0 | `ProfileScreen` visible; find `ProfileInfoColumn` with username; find `ProfileSubscriptionColumn` |
| 37 | Tap "Gold" membership card | Navigates to `/payment` with `PaymentArgumentModel(membershipType: MembershipType.GOLD)` | `PaymentScreen` visible; find text `'Gold Membership'`; find `'Proceed'` button |
| 38 | Tap "Proceed" | PaymentCubit.getTheMembership() | Mock Razorpay order creation; verify `state.razorpayModel != null` |
| 39 | Mock payment success | `_handlePaymentSuccess()` → navigates to `/home` | Route is `/home`; snackbar `"Payment Successful"` shown |

### Flow 2: Male User Onboarding → Chat → Upload Story

**Precondition:** App launched fresh. Same as Flow 1 but with male gender selection.

| Step | Action | Widget/Route | Verification |
|------|--------|-------------|-------------|
| 1–7 | Same as Flow 1 steps 1–7 | — | — |
| 8 | On gender screen, tap "I'm Male" | Sets `selectedIdentity = 'Man'`, `setGender("Male")` | Chip `"I'm Male"` selected |
| 9 | Tap "Next" | Route `/interestedGender` | Find `WhoCatchesYourEyeOnboardingScreen` |
| 10 | Tap "Woman" | `setGenderPreferences("Female")` | Chip `'Woman'` selected |
| 11–34 | Same as Flow 1 steps 12–35 (media → register → home) | — | After registration, land on HomeScreen |
| 35 | Tap Chat tab (index 3) | HomeScreen._selectedIndex = 3 | `ChatScreen` visible; find AppBar title `"Chats"` |
| 36 | Verify chat sections | ChatScreen | Find "Stories" section header (if stories exist); find "Recent Matches" section; find `StreamChannelListView` |
| 37 | Tap upload story icon | Top-right action bar, second icon (`upload_story.svg`) | Route `/uploadStory`; `UploadStoryScreen` visible |
| 38 | Verify upload screen | UploadStoryScreen | Find text `'Please, select a story.'` (no photo selected); find button `'Select Photo'` |
| 39 | Tap "Select Photo" | `UploadStoryBloc.add(selectStoryFromGallery())` | Mock image picker returns a file; image preview fills the background |
| 40 | Button changes to "Upload Story now" | State: `currentUploadedFile != null` | Find button text `'Upload Story now'` |
| 41 | Tap "Upload Story now" | `UploadStoryBloc.add(uploadStory())` | Mock API returns success; snackbar `"Story uploaded successfully"`; `context.pop(true)` |
| 42 | Back on ChatScreen | Chat tab active | `ChatScreenCubit.refreshStories()` called; stories section updated |

### Flow 3: Admin User Onboarding → Create Event → Home Screen IN APPROVAL State

**Precondition:** App launched fresh.

| Step | Action | Widget/Route | Verification |
|------|--------|-------------|-------------|
| 1 | App launches → splash → starter | Route `/starter` | StarterScreen visible |
| 2 | Tap "Create Admin Account" | Route `/register` with `extra: true` | `CreateAccounScreen(isAdmin: true)` visible; find text `'Create Account'` heading |
| 3 | Verify admin fields | Register screen | Find 5 `AuthIconTextField` widgets: Name, Email, Organization, Contact Number, Password |
| 4 | Enter name "AdminUser" | RegisterCubit.enteredUserName() | `state.name == "AdminUser"` |
| 5 | Enter email (random) | RegisterCubit.enteredEmail() | `state.email` non-empty |
| 6 | Enter organization "TestOrg" | RegisterCubit.enteredOrganization() | `state.organization == "TestOrg"` |
| 7 | Enter contact "9876543210" | RegisterCubit.enteredContactNumber() | `state.contactNumber == "9876543210"` |
| 8 | Enter password (>= 10 chars) | RegisterCubit.enteredPassword() | `state.password.length >= 10` |
| 9 | Tap "Register" | RegisterCubit.registerAsAAdmin() | Mock createAccount returns Success; auto-login via `_loginAdmin()` |
| 10 | Navigate to admin home | Route `/adminHome` (AdminDashboardScreen) | Find `GlintEventAuthAppbar` with `hasAdminActions: true`; find greeting `'Hello AdminUser'`; find organization row |
| 11 | Verify dashboard options | AdminDashboardScreen | Find "Create Event" button (Icon: `Icons.add`); find "Track Event" button (Icon: `Icons.graphic_eq`) |
| 12 | Tap "Create Event" | Route `/createEvent` (AdminCreateEventScreen) | Find text fields: event name, actual price, discount price, location, description, google map URL, lat, long, event by, tickets remaining, total tickets |
| 13 | Fill event name "Test Event" | `_eventNameController.text = "Test Event"` | Text field shows "Test Event" |
| 14 | Fill all required fields | Set all TextEditingControllers | All fields non-empty |
| 15 | Select event type "Normal" | Tap EventType option | Selection updated |
| 16 | Select date and time | Via BottomPicker | Date and time set |
| 17 | Tap "Preview" button | Route `/previewEvent` with `EventDetailsNavArguments` | `EventDetailScreen` shown with all entered data |
| 18 | Tap back / submit | AdminCreateEventCubit publishes event | Mock API returns Success; pop back to `/adminHome` |
| 19 | Verify event in dashboard | AdminDashboardScreen refreshes | "Recent Events" section shows new event card |
| 20 | Verify approval state | `RecentEventCard` widget | Event status shows `EventStatus` badge (pending/approval); verify `EventStatusContainer` renders correctly with text indicating the event requires Super Admin approval |

**Note:** The approval state is determined by the backend. The `SuperAdminDashboardScreen` shows events under "Event Requests" tab. Admin-created events are NOT auto-approved — they appear in the Super Admin's request queue.

### Flow 4: Login → Profiles Loaded → Send Message to Connected User

**Precondition:** User "Batman" exists with connections. Stream Chat is initialized.

| Step | Action | Widget/Route | Verification |
|------|--------|-------------|-------------|
| 1 | App launches → splash → starter | Route `/starter` | StarterScreen visible |
| 2 | Tap "Login" | Route `/auth` (LoginScreen, isAdmin: false) | Find `AuthIconTextField` for email (hint: `'Enter Email'`); find password field (hint: `'Enter Password'`) |
| 3 | Enter email `Batman@glintapp.io` | `_emailController.text` set | Text visible in field |
| 4 | Enter password `1234567890` | `_passwordController.text` set | Text visible (obscured) |
| 5 | Tap "Login" button | LoginBloc dispatches: `emailInput` → `passwordInput` → `login` | Loading indicator: `CircularProgressIndicator` shown with text `"Taking you in, just a moment,"` |
| 6 | Login succeeds (USER) | `LoginState.success(UsersType.USER)` | Route changes to `/home` |
| 7 | Verify home screen | HomeScreen | Bottom nav visible; default tab is PeopleScreen (index 2) |
| 8 | Verify profiles loaded | PeopleScreen | `PeopleCardsBloc` state: `isLoading == false`, `displayCards.isNotEmpty`; `CardSwiper` renders at least 1 `ScrollableProfileView` |
| 9 | Tap Chat tab (index 3) | HomeScreen._selectedIndex = 3 | ChatScreen visible; AppBar title `"Chats"` |
| 10 | Verify channels loaded | ChatScreen | `state.isChatReady == true`; `StreamChannelListView` renders `ChatChannelTile` widgets |
| 11 | Tap first chat channel | `ChatChannelTile.onTap` → pushNamed `chatWith` | Route `/chatWith`; `ChatWithScreen` visible |
| 12 | Verify chat UI | ChatWithScreen | Message list visible; text input field at bottom; send button present |
| 13 | Type "Hello!" | Message input controller | Text "Hello!" visible in input |
| 14 | Tap send | Stream Chat sends message | Message appears in message list; verify `find.text('Hello!')` in the sent message bubble |

### Flow 5: Login → Swipe Profiles → Navigate to Events

**Precondition:** User "Batman" is logged in. Mock returns 5+ profile cards.

| Step | Action | Widget/Route | Verification |
|------|--------|-------------|-------------|
| 1–7 | Same as Flow 4 steps 1–7 | — | On HomeScreen, PeopleScreen active |
| 8 | Verify swipe UI | PeopleScreen | `CardSwiper` widget present with key `ValueKey('people_card_swiper')`; at least 1 profile card visible |
| 9 | Swipe card LEFT | `CardSwiperDirection.left` | `PeopleCardsEvent.onLeftSwiped(userId, null)` dispatched; card animates off-screen left; next card appears |
| 10 | Swipe card RIGHT | `CardSwiperDirection.right` | `PeopleCardsEvent.onRightSwiped(userId, null)` dispatched; card animates off-screen right; next card appears |
| 11 | Swipe card LEFT | `CardSwiperDirection.left` | Third swipe processed; `currentIndex` advanced by 3 |
| 12 | Tap Event tab (index 1) | HomeScreen._selectedIndex = 1 | `EventBaseScreen` visible |
| 13 | Verify event tabs | EventBaseScreen | `TabBar` with 2 tabs: `'Events'` and `'Explore'`; `'Events'` tab active by default |
| 14 | Verify events list | EventsListScreen | Find banner with text `'Meet at Events!'`; if events exist, find `HotEvent` or `NearbyEventCard` widgets; if empty, find `EmptyEventContainer` |
| 15 | Tap "Explore" tab | Second tab | `CategoryListScreen` visible |

### Flow 6: Notification Handling Scenarios

**Notification types found in codebase (`GlintNotificationType` enum):**

| Type | Server String | Channel | User Navigation Target | Admin Navigation Target |
|------|--------------|---------|----------------------|----------------------|
| `match` | `'match'` | Matches | Home → Chat tab | Admin Home |
| `superLike` | `'super_like'` | Matches | Home → People tab → push Likes | Admin Home |
| `matchStory` | `'match_story'` | Matches | Home → Chat tab | Admin Home |
| `storyLike` | `'story_like'` | Matches | Home → Chat tab | Admin Home |
| `newEvent` | `'new_event'` | Events | Home → Event tab | Admin Home |
| `eventApproved` | `'event_approved'` | Events | (ignored for users) | Admin Home |
| `eventRejected` | `'event_rejected'` | Events | (ignored for users) | Admin Home |
| `ticketConfirmed` | `'ticket_confirmed'` | Tickets | Home → People tab → push Tickets | Admin Home |
| `ticketBookedByPartner` | `'ticket_booked_by_partner'` | Tickets | Home → People tab → push Tickets | Admin Home |
| `ticketCancelled` | `'ticket_cancelled'` | Tickets | Home → People tab → push Tickets | Admin Home |
| `refundProcessed` | `'refund_processed'` | Tickets | Home → People tab → push Tickets | Admin Home |
| `eventReminder` | `'event_reminder'` | Reminders | Home → People tab → push Tickets | Admin Home |
| `membershipExpiryReminder` | `'membership_expiry_reminder'` | Reminders | Home → Profile tab | Admin Home |
| `newMessage` | `'new_message'` | Matches | Home → Chat tab | Admin Home |
| `unknown` | any other | Matches | (ignored) | Admin Home |

**Test Steps for each notification type:**

For each notification type listed above:

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Construct `GlintNotificationPayload.fromMap({'notification_type': '<server_string>', ...relevant fields})` | Payload `type` matches expected `GlintNotificationType` enum value |
| 2 | Call `NotificationHandler.handleNavigation(data)` with user type = USER | Verify `GoRouter.goNamed()` called with expected route name |
| 3 | Verify correct tab selected | `HomeScreen.kTabChat` / `kTabEvent` / `kTabProfile` / `kTabPeople` matches expectation from table above |
| 4 | For types using `_goHomeAndPush` (superLike, ticket*, refund, eventReminder): verify secondary push | After home route settles, `pushNamed` called with `GlintMainRoutes.likes.name` or `GlintEventRoutes.tickets.name` |
| 5 | Repeat steps 1-4 with user type = ADMIN | Verify navigation goes to `GlintAdminDasboardRoutes.adminHome` for all types |

**Channel routing test:**
For each server notification_type string, call `GlintNotificationChannels.channelIdForType(type)` and verify it returns the correct channel ID from the table above.

### Onboarding Variations: Test Matrix

The onboarding flow is LINEAR — no conditional branching. The variation dimensions are:

**Dimension 1: Gender (screen `/gender`)**
- A: Female
- B: Male

**Dimension 2: Gender Preference (screen `/interestedGender`)**
- X: Woman (Female)
- Y: Man (Male)

**Dimension 3: Relationship Goals (screen `/pronouns`)**
- 1: Long Term
- 2: Something Casual
- 3: New Friends
- 4: Not Sure

**Dimension 4: Registration Type (from StarterScreen)**
- U: User (Create Account → onboarding → register)
- D: Admin (Create Admin Account → register directly)

| Combo ID | Gender | Preference | Relationship Goal | Reg Type | Expected Outcome |
|----------|--------|-----------|-------------------|----------|-----------------|
| A-X-1-U | Female | Woman | Long Term | User | Full onboarding → register → home |
| A-X-2-U | Female | Woman | Something Casual | User | Full onboarding → register → home |
| A-X-3-U | Female | Woman | New Friends | User | Full onboarding → register → home |
| A-X-4-U | Female | Woman | Not Sure | User | Full onboarding → register → home |
| A-Y-1-U | Female | Man | Long Term | User | Full onboarding → register → home |
| A-Y-2-U | Female | Man | Something Casual | User | Full onboarding → register → home |
| A-Y-3-U | Female | Man | New Friends | User | Full onboarding → register → home |
| A-Y-4-U | Female | Man | Not Sure | User | Full onboarding → register → home |
| B-X-1-U | Male | Woman | Long Term | User | Full onboarding → register → home |
| B-X-2-U | Male | Woman | Something Casual | User | Full onboarding → register → home |
| B-X-3-U | Male | Woman | New Friends | User | Full onboarding → register → home |
| B-X-4-U | Male | Woman | Not Sure | User | Full onboarding → register → home |
| B-Y-1-U | Male | Man | Long Term | User | Full onboarding → register → home |
| B-Y-2-U | Male | Man | Something Casual | User | Full onboarding → register → home |
| B-Y-3-U | Male | Man | New Friends | User | Full onboarding → register → home |
| B-Y-4-U | Male | Man | Not Sure | User | Full onboarding → register → home |
| —-D | N/A | N/A | N/A | Admin | name+email+org+contact+password → /adminHome |

**Total: 17 combinations** (16 user + 1 admin).

All user combinations follow the same screen flow; only the selected values differ. The test should parameterize gender, preference, and relationship goal as inputs and verify the corresponding `RegisterUserRequest` fields match at the end.

**Onboarding Resume Test (per `OnBoardingCompletedTill` state):**

| Saved State | Expected Resume Screen |
|------------|----------------------|
| `NOT_STARTED` | `/name` (EnterNameOnboardingScreen) |
| `NAME_PROVIDED` | `/dob` (DateOfBirthOnboardingScreen) |
| `AGE_CALCULATED` | `/gender` (IdentifyYourselfOnboardingScreen) |
| `GENDER_SELECTED` | `/interestedGender` (WhoCatchesYourEyeOnboardingScreen) |
| `CHOICE_OF_GENDER_SELECTED` | `/media` (UploadPhotosOnboardingScreen) |
| `IMAGES_SELECTED` | `/pronouns` (GetSetGlintOnboardingScreen) |
| `PRONOUNS_DONE` | `/interests` (InterestsAndVibeOnboardingScreen) |
| `INTERESTS_DONE` | `/bio` (OneLastStepOnboardingScreen) |
| `BIO_DONE` | `/location` (LocationPermissionOnboardingScreen) |
| `COMPLETED` | `/register` (CreateAccounScreen) |

---

## Section 4: Integration Test Specs (60% of total coverage)

### 4.1 Splash Screen

**What to mock:** `IsUserLoggedInUsecase`, `AsyncEncryptedSharedPreferenceHelper`, `ChatRepo`
**What to verify:** Correct routing based on auth state.

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `SplashScreen` with no refresh token | `SplashScreenBloc` emits `navigateTo('starter')` |
| 2 | Pump with refresh token + userRole = `'USER'` | Emits `navigateTo('home')` |
| 3 | Pump with refresh token + userRole = `'ADMIN'` | Emits `navigateTo('adminHome')` |
| 4 | Pump with refresh token + userRole = `'SUPER_ADMIN'` | Emits `navigateTo('superAdminHome')` |
| 5 | Verify Lottie animation plays | Find `Lottie.asset('lib/assets/animation/splash.json')` |
| 6 | Verify navigation waits for animation completion | Route change only after `AnimationStatus.completed` |

**Edge cases:** Error in `IsUserLoggedInUsecase` → `splashFailure` state → animation still plays.

### 4.2 Login Screen

**What to mock:** `LoginBloc` (or its dependencies: `SignInUserUseCase`, `AuthenticationRepo`)
**What to verify:** UI rendering, validation, navigation on success/error.

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `LoginScreen(isAdmin: false)` | Find email field (hint `'Enter Email'`), password field (hint `'Enter Password'`), `'Login'` button |
| 2 | Submit with empty email | Error snackbar: `'Email cannot be empty.'` |
| 3 | Submit with invalid email "notanemail" | Error snackbar: `'Please enter a valid email address.'` |
| 4 | Submit with short password "123" | Error snackbar containing `'Password must be at least'` |
| 5 | Submit valid credentials | Loading state shows `CircularProgressIndicator` + text `"Taking you in, just a moment,"` |
| 6 | Mock success with `UsersType.USER` | `context.go` called with `/home` |
| 7 | Mock success with `UsersType.ADMIN` | `context.go` called with `/adminHome` |
| 8 | Mock error | Snackbar with error message |
| 9 | Tap "Forgot your password?" | Push to `/resetPassword` route |
| 10 | Tap "Create now" | Push to `/starter` |

**Admin variant:** Pump `LoginScreen(isAdmin: true)` — verify `GlintEventAuthAppbar` present; registration link goes to `/register`.

**Edge cases:** Loading state (isLoading: true) shows spinner; network timeout → error snackbar.

### 4.3 Reset Password Flow

**What to mock:** `ResetPasswordBloc` (or: `SendOtpUseCase`, `ResetPasswordWithOtpUseCase`, `ForgotPasswordRepo`)

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `ResetPasswordScreen` | Find email field, `'Get OTP'` button |
| 2 | Tap "Get OTP" with valid email | `ResetPasswordEvent.sendOtp(email)` dispatched; on `otpSent()` → navigate to `/otp/:email` |
| 3 | Pump `EnterOtpScreen(email: 'test@test.com')` | Find `Pinput` widget (4-digit input); "Confirm" button disabled when length < 4 |
| 4 | Enter 4 digits "1234" | "Confirm" button becomes enabled |
| 5 | Tap "Confirm" | Navigate to `/recreatePassword` with `extra: {'email': ..., 'otp': '1234'}` |
| 6 | Pump `CreatePasswordScreen` | Find 2 password fields; "Confirm" button |
| 7 | Enter mismatched passwords | Validation error: buttons disabled |
| 8 | Enter matching passwords (>= 10 chars) | `ResetPasswordEvent.resetPassword(email, otp, password)` dispatched |
| 9 | Mock `passwordResetSuccess()` | Navigate to `/passwordSuccess` |
| 10 | Verify `PasswordChangeConfirmationScreen` | Find text `'Password'` and `'Successfully Changed!!'`; find `'Login Now'` button |
| 11 | Tap "Login Now" | Navigate to `/auth` |

**Edge cases:** OTP send failure → error snackbar → stays on reset screen; password reset failure → error state.

### 4.4 Event Details Screen

**What to mock:** `EventDetailCubit`, `EventsRepo`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `EventDetailScreen` with `EventDetailsNavArguments(eventId: 1)` | Loading state: `CircularProgressIndicator` visible |
| 2 | Mock successful event fetch | Find event title text (non-empty); find `_EventDetails` with date, time, location labels |
| 3 | Verify image carousel | `CarouselSlider` present with event images |
| 4 | Verify pricing section | Find `_EventPricing` widget with price text `'₹ <price>'`, `'/ person'`, `'<N> days left'` chip |
| 5 | Verify "About Event" section | Find `_AboutEvent` with description text |
| 6 | Verify "Event by" label | Find `RichText` with `'Event by '` text |
| 7 | Verify location map | If coordinates non-zero: find `EventLocationMapButton` |
| 8 | Pump with admin view (`isAdminView: true`) | Find `_AdminEventDetails` section with management rows: Tickets, Status, Hot Event, Confirmed, Coordinator, Book by, Categories |

**Edge cases:**
- Error state: `errorMessage != null && eventDetails == null` → find `_ErrorState` with `'Failed to load event details'` text and `'Retry'` button
- Tap "Retry" → `EventDetailCubit.retry()` called
- Null/empty images → placeholder `event_banner_placeholder.png` shown
- Discount activated: show old price with `lineThrough` decoration

### 4.5 Settings Screen

**What to mock:** `SettingsCubit`, `AsyncEncryptedSharedPreferenceHelper`, `LogoutUserUsecase`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `ProfileSettingsScreen` wrapped in `BlocProvider<SettingsCubit>` | Find AppBar title `'Settings'` |
| 2 | Verify location tile | Find `_LocationTile` with text `'Add Location Manually'`; find `TextField` with hint `'Bhilai, Chhattisgarh'` |
| 3 | Verify notification master toggle | Find `Switch.adaptive` for `'Allow Notifications'`; verify `state.isNotificationsEnabled` |
| 4 | Toggle notifications ON | `SettingsCubit.toggleNotifications(true)` | Switch shows ON; sub-switches become enabled |
| 5 | Verify sub-notification switches | Find 4 switches: `'Matches'`, `'Events'`, `'Tickets'`, `'Reminders'` with subtitles |
| 6 | Toggle "Matches" OFF | `SettingsCubit.toggleMatches(false)` | Switch for Matches shows OFF |
| 7 | Toggle notifications master OFF | `SettingsCubit.toggleNotifications(false)` | All sub-switches become disabled (onChanged: null) |
| 8 | Verify support section | Find `'Contact Us'` ListTile and `'FAQs'` ListTile |
| 9 | Verify "Log Out" button | Find `GlintIconElevatedButton` with text `'Log Out'` |
| 10 | Tap "Log Out" | Dialog appears with `'Logout Account?'` title, `'Are you sure you want to logout?'` |
| 11 | Tap "Yes, Logout" in dialog | `LogoutUserUsecase.perform()` called; on success → navigate to `/starter` |
| 12 | Verify "Delete Your Account" button | Find button with text `'Delete Your Account'` |
| 13 | Tap "Delete Your Account" | Dialog with `'Delete Glint Profile'`; tap "Yes, Delete" → snackbar with `"We are working on deleting User, until then please log out"` |
| 14 | Verify app version | Find `state.appVersion` text |
| 15 | Verify "Made with" footer | Find text containing `'Made with'` and `'in Bhilai'` |

**Edge cases:** Sub-switches disabled when master toggle is OFF.

### 4.6 Likes Screen

**What to mock:** `LikesScreenCubit`, `LikesDataRepo`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `LikesScreen` | Loading: `CircularProgressIndicator` visible |
| 2 | Mock loaded state with profiles | Find `SliverGlintCustomAppBar` with title `'Liked you'` |
| 3 | Verify profile view banner | Find `GlintGradientTextWidget` with profile view count number |
| 4 | Verify top profiles section | If `topProfiles` non-empty: find `'Top profiles'` heading; find horizontal `ListView` with `GlintTopProfileContainer` items |
| 5 | Verify liked profiles grid | If `superLikedAndLikedProfiles` non-empty: find `'People liked your profile'`; find `GridView` with `GlintLikedYouProfileContainer` items |
| 6 | Mock empty state | `topProfiles.isEmpty && superLikedAndLikedProfiles.isEmpty` | Find `GlintEmptyState` with title `'No likes yet'` and subtitle `'Start liking profiles to get discovered.'` |

**Edge cases:** Empty top profiles only → grid still visible; empty grid only → top profiles still visible.

### 4.7 Notification Screen

**What to mock:** `NotificationCubit`, `NotificationRepo`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `NotificationScreen` | Loading: `CircularProgressIndicator` in `SliverFillRemaining` |
| 2 | Mock loaded state with groups | Find `SliverGlintCustomAppBar` with title `'Notifications'`, subtitle `'Never miss a moment that matters.'` |
| 3 | Verify banner | Find `'Want More Matches?'` text inside banner |
| 4 | Verify grouped notifications | Find group labels: `'Today'`, `'Yesterday'`, `'Earlier'` (depending on data); each group contains `GlintNotificationTile` widgets |
| 5 | Verify tile content | Each `GlintNotificationTile` has `title`, `subtitle` (`body`), `date`, `isRead` flag, and icon based on `NotificationType` |
| 6 | Verify icon mapping | `match` → `NotificationTileIconState.match`; `event` → `.event`; `activity`/`reminder` → `.stat` |
| 7 | Mock empty state | `notificationGroups.isEmpty` | Find `GlintEmptyState` with title `'No updates yet'` and subtitle `'Check out the latest events happening near you!'` |
| 8 | Mock error state | `error.isNotEmpty` | Find text `'Due to Server Failure, please try again later.'` and `'Retry'` button |
| 9 | Tap "Retry" | `NotificationCubit.fetchNotifications()` called |

**Edge cases:** Only today's notifications → only "Today" group; mixed dates → all 3 groups.

### 4.8 Filter Preference Screen

**What to mock:** `FilterPreferencesCubit`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `FilterPreferenceScreen` | Find `SliverGlintCustomAppBar` with title `'Filter Your Preferences'` |
| 2 | Verify age/distance card | Find `GlintAgeDistanceCard` with `initialMinAge`, `initialMaxAge`, `initialMaxDistance` from state |
| 3 | Adjust age range | Interact with age slider | `FilterPreferencesCubit.updateAgePreferences(min, max)` called |
| 4 | Adjust distance | Interact with distance slider | `FilterPreferencesCubit.updateDistancePreferences(maxDistance)` called |
| 5 | Verify interests section | Find `GlintInterestsSelection` widget |
| 6 | Tap "Apply Changes" | `context.pop()` called; `FilterPreferencesCubit.applyChanges()` called |

**Edge cases:** Default values load from state; slider boundaries respected.

### 4.9 Payment Screen

**What to mock:** `PaymentCubit`, `PaymentRepo`, `Razorpay`

**Membership payment:**

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump with `PaymentArgumentModel(membershipType: MembershipType.GOLD, ...)` | `PaymentCubit.collectPaymentRequest()` called; find `'Gold Membership'` title |
| 2 | Verify Gold features | Find feature texts: `'5 Superlikes'`, `'3 SuperDM'`, `'3 Rewinds'`, `'Unlimited Likes'`, `'See Who Likes You'`, `'7 AI Chat Suggestion'`, `'Hide Ads'`, `'Message First'` |
| 3 | Verify amount | Find `'₹ <amount>'` text and `'Amount to be paid'` label |
| 4 | Tap "Proceed" | `PaymentCubit.getTheMembership()` called |
| 5 | Mock Razorpay order | `state.razorpayModel != null` → `_razorpay.open()` called |

**Platinum membership:** Same as above but find `'Platinum Membership'` with features: `'8 Superlikes'`, `'7 SuperDM'`, `'7 Rewinds'`, `'Profile Boost'`, `'15 AI Chat Suggestion'`.

**Event ticket payment:**

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump with `PaymentArgumentModel(eventId: '1', ...)`, membership null | Find `'Event Ticket Booking'` text |
| 2 | Verify ticket holders | Find 2 `_buildTicketHolder` rows: "You" and partner name |
| 3 | Verify price details | Find rows: `'Ticket cost per person'`, `'Person(s)'`, `'Ticket Amount'`, `'GST'` |
| 4 | Tap "Proceed" | `PaymentCubit.bookTheEvent()` called |
| 5 | Mock Razorpay success | Navigate to `/confirmTicket` with `ConfirmTicketNavArguments` |

**Edge cases:** Loading state shows spinner; error state shows snackbar; payment failure → snackbar with error message.

### 4.10 Profile Screen

**What to mock:** `ProfileHandlingCubit`, `ProfileRepo`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `ProfileScreen` | Find `ProfileInfoColumn` and `ProfileSubscriptionColumn` |
| 2 | Verify profile info | Find username text, user age, profile image (or fallback URL) |
| 3 | Verify progress indicator | `profileCompletion` value (0.0–1.0) reflected in UI |
| 4 | Verify subscription counts | Find super like count, rewind count, super DM count from `membershipEntity` |

**Edge cases:** Null `previewProfileModel` → defaults: username = "Username", age = "18".

### 4.11 Event Base Screen (Tabs)

**What to mock:** `EventBaseCubit`, `EventsRepo`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `EventBaseScreen` | Find `DefaultTabController` with 2 tabs; find tab labels `'Events'` and `'Explore'` |
| 2 | Verify Events tab (default) | `EventsListScreen` visible; find banner `'Meet at Events!'` |
| 3 | Mock hot events list | Find `'Hot Events'` heading; `HotEvent` cards render |
| 4 | Mock normal events list | Find `'Events'` heading; `NearbyEventCard` cards render |
| 5 | Tap event info icon | Navigate to `/event/eventDetails` with event ID |
| 6 | Tap event card (fetch profiles) | `EventBaseCubit.fetchSelectedEventProfiles(eventId)` and `markInterestedUserIfNotAlready(eventId)` called; navigate to `/event/peopleInterested` |
| 7 | Switch to Explore tab | `CategoryListScreen` visible |
| 8 | Mock empty events | `hotEvents.isEmpty && normalEvents.isEmpty` → find `EmptyEventContainer` |

### 4.12 Ticket History Screen

**What to mock:** `TicketHistoryCubit`, `EventsRepo`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `EventTicketHistoryScreen` | Loading: `CircularProgressIndicator` |
| 2 | Mock tickets loaded | Find AppBar title `'Your Tickets'`; `ListView` with `_TicketHistoryCard` items |
| 3 | Verify card content | Each card shows: event name, date (`GlintIconLabel` with calendar icon), location (`GlintIconLabel` with location icon), matched user avatars, `'You & <username>'` |
| 4 | Verify "days left" badge | If event not passed: find chip with `'<N> days left'` text |
| 5 | Tap a ticket card | Navigate to `/confirmTicket` with `ConfirmTicketNavArguments` |
| 6 | Scroll to bottom | `TicketHistoryCubit.loadMore()` called when within 200px of bottom |
| 7 | Mock loading more | `GlintPaginationLoader` visible at bottom |
| 8 | Mock empty state | Find text `'No tickets yet.'` |

### 4.13 Admin Dashboard Screen

**What to mock:** `AdminDashboardBloc`, `AdminDashboardRepo`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `AdminDashboardScreen` | Loading: spinner; then find `GlintEventAuthAppbar(hasAdminActions: true)` |
| 2 | Verify greeting | Find text `'Hello <adminUserName>'` |
| 3 | Verify organization | Find organization name in row with org icon |
| 4 | Verify action buttons | Find "Create Event" button; find "Track Event" button |
| 5 | Tap "Create Event" | Push to `/createEvent` with `AdminCreateEventNavArguments(null, refreshCallback)` |
| 6 | Tap "Track Event" | Push to `/adminPublishedEvents` |
| 7 | Verify recent events | Find `'Recent Events'` heading; `RecentEventCard` widgets with `eventName`, `eventDate`, `eventStatus` |
| 8 | Mock empty events | No `RecentEventCard` widgets rendered |

### 4.14 Super Admin Dashboard Screen

**What to mock:** `SuperAdminDashboardBloc`, `AdminDashboardRepo`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `SuperAdminDashboardScreen` | Find `GlintEventAuthAppbar(hasAdminActions: true)`; greeting `'Hello Admin!'` |
| 2 | Verify tabs | Find 2 `ChoiceChip`: `'Live'` and `'Event Requests'` |
| 3 | Tap "Live" chip | `SuperAdminDashboardEvent.selectLive()` dispatched; `state.currentTab == EventDisplayType.live` |
| 4 | Tap "Event Requests" chip | `SuperAdminDashboardEvent.selectRequests()` dispatched; badge shows request count |
| 5 | Verify event cards | `SuperAdminEventPreviewCard` widgets with event name, date, organiser |
| 6 | Tap "Accept" on event card | `SuperAdminDashboardEvent.approveEvent(eventId)` dispatched |
| 7 | Tap "Reject" on event card | `SuperAdminDashboardEvent.rejectEvent(eventId)` dispatched |
| 8 | Mock empty list | Find text `"No Data available, wait for Admins to create more events."` |

### 4.15 Home Screen Navigation

**What to mock:** `ChatScreenCubit`, `PeopleCardsBloc`, `EventBaseCubit`, `UserInfoManagerCubit`, `InternetStatusCheckerCubit`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `HomeScreen(initialTab: HomeScreen.kTabPeople)` | PeopleScreen active; bottom nav renders 4 icons (user, event, logo, chat) |
| 2 | Tap profile icon (index 0) | `ProfileScreen` visible via `IndexedStack`; profile icon has `AppColours.primaryBlue` |
| 3 | Tap event icon (index 1) | `EventBaseScreen` visible |
| 4 | Tap logo icon (index 2) | `PeopleScreen` visible |
| 5 | Tap chat icon (index 3) | `ChatScreen` visible; AppBar is null (no GlintAppBar for chat) |
| 6 | Verify AppBar changes | Tabs 0–2 show `GlintAppBar`; tab 3 has `appBar: null` |
| 7 | Verify `initialTab` from `extra` | Pump with `initialTab: HomeScreen.kTabChat` → chat tab active |

**Edge cases:** Internet disconnected → snackbar `"No Internet available"`; `UserInfoManagerCubit` error → snackbar with error.

### 4.16 People Screen (Card Swiper)

**What to mock:** `PeopleCardsBloc`, `PeopleRepo`, `UserInfoManagerCubit`

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Loading state | `CircularProgressIndicator` visible |
| 2 | Empty profiles | `EmptyPeopleStateView` with `"It's a little quiet here"` title, `'Search'` button |
| 3 | Tap "Search" | Navigate to `/filter` |
| 4 | Profiles loaded | `CardSwiper` with key `ValueKey('people_card_swiper')` visible; `ScrollableProfileView` cards render |
| 5 | Left swipe | `PeopleCardsEvent.onLeftSwiped(userId, null)` dispatched |
| 6 | Right swipe | `PeopleCardsEvent.onRightSwiped(userId, null)` dispatched |
| 7 | Up swipe (super like) | `PeopleCardsBloc.superLikeUser(userId, null)` called |
| 8 | Undo swipe | `PeopleCardsEvent.undo()` dispatched |
| 9 | Error in state | Snackbar with `state.error` text |

### 4.17 Service Screen (Placeholder)

| Step | Action | Verification |
|------|--------|-------------|
| 1 | Pump `ServiceScreen` | Find text containing `'Service Screen'` |

---

## Section 5: File Structure

```
test/
  helpers/
    mock_services.dart          -- All Mock classes + registerTestDependencies()
    test_credentials.dart       -- TestCredentials (random email/password generators + Batman creds)
    pump_helpers.dart           -- Helper to pump widgets with required BlocProviders and GoRouter
    fake_data.dart              -- Factory methods for fake domain models (PeopleCardModel, EventDetailsDomainModel, etc.)
  e2e/
    onboarding_to_membership_test.dart       -- Flow 1: Normal user onboarding → profile → buy membership
    onboarding_to_story_test.dart            -- Flow 2: Male user onboarding → chat → upload story
    admin_onboarding_to_event_test.dart      -- Flow 3: Admin onboarding → create event → approval state
    login_to_chat_message_test.dart          -- Flow 4: Login → profiles loaded → send message
    login_to_swipe_events_test.dart          -- Flow 5: Login → swipe profiles → navigate to events
    notification_handling_test.dart           -- Flow 6: All notification types → correct screen
    onboarding_variations_test.dart          -- 17 onboarding combos (parameterized)
    onboarding_resume_test.dart              -- 10 resume states → correct screen
  integration/
    splash_screen_test.dart                  -- 4.1: Splash routing by auth state
    login_screen_test.dart                   -- 4.2: Login UI, validation, navigation
    reset_password_flow_test.dart            -- 4.3: Full reset password flow
    event_detail_screen_test.dart            -- 4.4: Event details rendering + edge cases
    settings_screen_test.dart                -- 4.5: Settings toggles, logout, delete
    likes_screen_test.dart                   -- 4.6: Likes display + empty state
    notification_screen_test.dart            -- 4.7: Notification groups + error/empty states
    filter_preference_screen_test.dart       -- 4.8: Filter sliders + apply
    payment_screen_test.dart                 -- 4.9: Membership + event ticket payment
    profile_screen_test.dart                 -- 4.10: Profile info + subscription counts
    event_base_screen_test.dart              -- 4.11: Event tabs + list rendering
    ticket_history_screen_test.dart          -- 4.12: Ticket list + pagination
    admin_dashboard_screen_test.dart         -- 4.13: Admin dashboard actions + events
    super_admin_dashboard_screen_test.dart   -- 4.14: Super admin approve/reject
    home_screen_test.dart                    -- 4.15: Bottom nav tab switching
    people_screen_test.dart                  -- 4.16: Card swiper + swipe actions
    service_screen_test.dart                 -- 4.17: Placeholder screen
```

---

## Section 6: Execution Order

| Order | File | Depends On | Spec Reference |
|-------|------|-----------|---------------|
| 1 | `test/helpers/mock_services.dart` | Nothing | Section 2.2 |
| 2 | `test/helpers/test_credentials.dart` | Nothing | Section 2.3 |
| 3 | `test/helpers/fake_data.dart` | Nothing | Section 2 (factory methods for test data) |
| 4 | `test/helpers/pump_helpers.dart` | mock_services.dart, fake_data.dart | Section 2 (widget pumping with BLoC providers) |
| 5 | `test/integration/splash_screen_test.dart` | helpers/* | Section 4.1 |
| 6 | `test/integration/login_screen_test.dart` | helpers/* | Section 4.2 |
| 7 | `test/integration/reset_password_flow_test.dart` | helpers/* | Section 4.3 |
| 8 | `test/integration/profile_screen_test.dart` | helpers/* | Section 4.10 |
| 9 | `test/integration/home_screen_test.dart` | helpers/* | Section 4.15 |
| 10 | `test/integration/people_screen_test.dart` | helpers/* | Section 4.16 |
| 11 | `test/integration/likes_screen_test.dart` | helpers/* | Section 4.6 |
| 12 | `test/integration/notification_screen_test.dart` | helpers/* | Section 4.7 |
| 13 | `test/integration/filter_preference_screen_test.dart` | helpers/* | Section 4.8 |
| 14 | `test/integration/event_base_screen_test.dart` | helpers/* | Section 4.11 |
| 15 | `test/integration/event_detail_screen_test.dart` | helpers/* | Section 4.4 |
| 16 | `test/integration/ticket_history_screen_test.dart` | helpers/* | Section 4.12 |
| 17 | `test/integration/payment_screen_test.dart` | helpers/* | Section 4.9 |
| 18 | `test/integration/settings_screen_test.dart` | helpers/* | Section 4.5 |
| 19 | `test/integration/admin_dashboard_screen_test.dart` | helpers/* | Section 4.13 |
| 20 | `test/integration/super_admin_dashboard_screen_test.dart` | helpers/* | Section 4.14 |
| 21 | `test/integration/service_screen_test.dart` | helpers/* | Section 4.17 |
| 22 | `test/e2e/onboarding_variations_test.dart` | helpers/* | Section 3, Onboarding Variations |
| 23 | `test/e2e/onboarding_resume_test.dart` | helpers/* | Section 3, Resume Test |
| 24 | `test/e2e/onboarding_to_membership_test.dart` | helpers/* | Section 3, Flow 1 |
| 25 | `test/e2e/onboarding_to_story_test.dart` | helpers/* | Section 3, Flow 2 |
| 26 | `test/e2e/admin_onboarding_to_event_test.dart` | helpers/* | Section 3, Flow 3 |
| 27 | `test/e2e/login_to_chat_message_test.dart` | helpers/* | Section 3, Flow 4 |
| 28 | `test/e2e/login_to_swipe_events_test.dart` | helpers/* | Section 3, Flow 5 |
| 29 | `test/e2e/notification_handling_test.dart` | helpers/* | Section 3, Flow 6 |

---

## Ambiguities

| Item | Description | Assumption |
|------|------------|-----------|
| `ServiceScreen` | Contains placeholder text `'Service Screen, needed to hidden and released in next version'`. No real functionality. | Write a trivial render test only. |
| `ChatWithScreen` internal widgets | The `ChatWithScreen` depends heavily on Stream Chat SDK widgets. Mocking Stream SDK internals (`StreamChannel`, `StreamMessageListView`, `StreamMessageInput`) may be complex. | Test navigation TO ChatWithScreen and verify it mounts without crash. Do not test Stream SDK internals. |
| `Razorpay` integration | `Razorpay` is a native plugin. Cannot simulate payment flow in widget tests. | Mock `PaymentCubit` state transitions. Verify `_razorpay.open()` is called with correct params. Do not test actual Razorpay UI. |
| `VideoCall` screen | `ChatWithVideoCallScreen` exists but its implementation was not deeply inspected. | Write a render test only. |
| `OneTimeViewScreen` | Exists for one-time photo viewing. | Write a render test with `OneTimeViewNavArguments`. |
| `MatchPopupScreen` | `match_popup_screen.dart` exists in people feature. It is likely shown as a dialog/overlay on match. | Include in people integration test if triggered by swipe match. Mark as secondary. |
| No explicit widget keys | The codebase uses very few explicit `Key` objects on widgets. Tests will rely on `find.text()`, `find.byType()`, `find.byIcon()` rather than `find.byKey()`. | All test step references use widget types and text finders instead of keys. |
| `EventBaseScreen` lazy BLoC | `EventBaseCubit` is created lazily in the route config. Tests must provide it via `BlocProvider`. | `pump_helpers.dart` should wrap `EventBaseScreen` with `BlocProvider<EventBaseCubit>`. |
| Password min length discrepancy | `LoginBloc` uses `minLength = 9` but error message says "at least 10". `RegisterCubit` uses `minLength = 10`. | Test with the actual code behavior (9 for login, 10 for register). Flag this as a bug in login validation. |
| "Everyone" gender option | Commented out in both `IdentifyYourselfOnboardingScreen` and `WhoCatchesYourEyeOnboardingScreen`. | Do not test "Everyone" option. It is not active. |
