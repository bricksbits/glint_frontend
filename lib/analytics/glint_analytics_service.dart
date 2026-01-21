import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:glint_frontend/analytics/glint_analytics_events.dart';

class GlintAnalyticService {
  static get _firebaseAnalyticsInstance => FirebaseAnalytics.instance;

  static void setAnalyticsEnable() {
    _firebaseAnalyticsInstance.setAnalyticsCollectionEnabled(true);
  }

  static void logError(
    String? recordName,
    String? recordTime,
    String? recordMessage,
    String? exceptionMessage,
    StackTrace? stackTrace,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: "flutter_error",
      parameters: {
        "recordTime": recordTime ?? "--",
        "recordName": recordName ?? "--",
        "recordMessage": recordMessage ?? "--",
        "exception": exceptionMessage ?? "--",
      },
    );
  }

  /// FEATURE : AUTHENTICATION
  static void loggingEvent(
    String role,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.LOGIN_USER,
      parameters: {"role": role},
    );
  }

  static void forgotPasswordEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.FORGOT_PASSWORD,
    );
  }

  static void emailIdProvidedForForgotPasswordEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.FORGOT_PASSWORD_EMAIL_ID,
    );
  }

  static void otpProvidedForForgotPasswordEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.FORGOT_PASSWORD_OTP,
    );
  }

  static void newPasswordProvidedForForgotPasswordEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.FORGOT_PASSWORD_NEW_PASSWORD,
    );
  }

  static void registerSuccessfullyEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.CREATE_USER,
    );
  }

  /// Feature : ONBOARDING

  static void onBoardStartedEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_BOARDING_STARTED,
    );
  }

  static void onBoardImageProvidedEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_BOARDING_IMAGES_PROVIDED,
    );
  }

  static void onBoardCompletedBioEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_BOARDING_BIO,
    );
  }

  static void onBoardNavigatedDirectlyEvent(String screenName) {
    _firebaseAnalyticsInstance.logEvent(
        name: GlintAnalyticsEvents.ON_BOARDING_NAVIDATE_DIRECTLY,
        parameters: {"screen": screenName});
  }

  static void onBoardLocationPermissionEvent(bool isPermissionGranted) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_BOARDING_LOCATION_PERMISSION,
      parameters: {"permission": isPermissionGranted ? "Granted" : "Rejected"},
    );
  }

  static void onNavItemClickedEvent(GlintNavItemAnalyticsEvents event) {
    final navItemEventName = switch (event) {
      GlintNavItemAnalyticsEvents.PROFILE =>
        GlintAnalyticsEvents.ON_PROFILE_NAV,
      GlintNavItemAnalyticsEvents.EVENT => GlintAnalyticsEvents.ON_EVENT_NAV,
      GlintNavItemAnalyticsEvents.HOME => GlintAnalyticsEvents.ON_HOME_NAV,
      GlintNavItemAnalyticsEvents.CHAT => GlintAnalyticsEvents.ON_CHAT_NAV,
    };
    _firebaseAnalyticsInstance.logEvent(
      name: navItemEventName,
    );
  }

  /// Feature: HOME SCREEN
  static void onCardActionEvent(
    GlintSwipeGestureAnalyticsEvents event,
    bool isPremiumUser,
  ) {
    String cardEventActionName = switch (event) {
      GlintSwipeGestureAnalyticsEvents.RIGHT =>
        GlintAnalyticsEvents.ON_RIGHT_SWIPE,
      GlintSwipeGestureAnalyticsEvents.LEFT =>
        GlintAnalyticsEvents.ON_LEFT_SWIPE,
      GlintSwipeGestureAnalyticsEvents.SUPER =>
        GlintAnalyticsEvents.ON_SUPER_LIKE,
      GlintSwipeGestureAnalyticsEvents.DM => "super_dm",
    };

    _firebaseAnalyticsInstance.logEvent(
      name: cardEventActionName,
      parameters: {"premium": isPremiumUser ? "Yes" : "No"},
    );
  }

  static void onRewindEvent(
    bool isPremiumUser,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_REWIND,
      parameters: {"premium": isPremiumUser ? "Yes" : "No"},
    );
  }

  static void onLikeScreenEvent(
    bool isPremiumUser,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_LIKE,
    );
  }

  static void onSearchScreenEvent(
    bool isPremiumUser,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SEARCH_SCREEN,
    );
  }

  static void onNotificationScreenEvent(
    bool isPremiumUser,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_NOTIFICATION_SCREEN,
    );
  }

  /// Feature : Notifications
  static void onNotificationItemClickedEvent(
    String notificationType,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_NOTIFICATION_ITEM,
      parameters: {"type": notificationType},
    );
  }

  static void onLikedItemClickedEvent(
    String oppositeUserId,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_LIKE_PROFILE_ITEM,
      parameters: {"opposite_id": oppositeUserId},
    );
  }

  /// Feature : Search
  static void onSearchApplyEvent(
    String distanceSelected,
    String ageSet,
    bool isLocationPermissionEnabled,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SEARCH_APPLY,
      parameters: {
        "distance": distanceSelected,
        "age": ageSet,
        "permission": isLocationPermissionEnabled ? "Granted" : "Rejected",
      },
    );
  }

  /// Feature : EVENT
  static void onEventCardItemClickedEvent(
    String eventId,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_CARD_CLICKED,
      parameters: {"event_id": eventId},
    );
  }

  static void onEventCardItemInfoClickedEvent(
    String eventId,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_CARD_INFO,
      parameters: {"event_id": eventId},
    );
  }

  // Recent or Nearby
  static void onEventFilterTabsEvent(
    String tab,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_FILTER_TAB_CLICKED,
      parameters: {
        "tab": tab,
      },
    );
  }

  // Events Or Explore
  static void onEventTabsEvent(
    String tab,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_TYPE_TAB_CLICKED,
      parameters: {
        "tab": tab,
      },
    );
  }

  static void onEventDetailsMapEvent(
    String eventId,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_MAP_CLICKED,
      parameters: {
        "event_id": eventId,
      },
    );
  }

  static void onEventDetailsImagesScrolledEvent(
    String eventId,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_IMAGES_SCROLLED,
      parameters: {
        "event_id": eventId,
      },
    );
  }

  static void onNoEventsInstaLinksClickedEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_TO_INSTA,
    );
  }

  static void onEventsTicketHistoryClickedEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_TICKET_HISTORY,
    );
  }

  static void onNoEventsWebsiteLinksClickedEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_TO_WEBSITE,
    );
  }

  /// Feature : CHAT
  static void onUploadStoriesEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_UPLOAD_STORY,
    );
  }

  static void onUserThumbnailClickedEvent(
    String oppositeUserId,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_CHAT_PROFILE_CLICKED,
      parameters: {
        "opposite_id": oppositeUserId,
      },
    );
  }

  static void onVideoCallClickedEvent(
    String userId,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_CHAT_VIDEO_CALL_CLICKED,
      parameters: {
        "user_id": userId,
      },
    );
  }

  static void onSettingIconMenuClickedEvent(
    String channelId,
    String oppositeId,
    String matchId,
  ) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_CHAT_SETTINGS_CLICKED,
      parameters: {
        "channel_id": channelId,
        "opposite_id": oppositeId,
        "match_id": matchId,
      },
    );
  }

  static void onMediaSelectedEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_CHAT_MEDIA_CLICKED,
    );
  }

  static void onRefreshHitEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_CHAT_REFRESH,
    );
  }

  /// Feature : PROFILE
  static void onProfileSettingsEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_SETTING,
    );
  }

  static void onTicketHistoryEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_TICKET_HISTORY,
    );
  }

  static void onEditProfileEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_EDIT,
    );
  }

  static void onVerificationProfileEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_VERIFICATION,
    );
  }

  static void onSubscriptionProfileEvent(
    String subscriptionType,
  ) {
    _firebaseAnalyticsInstance.logEvent(
        name: GlintAnalyticsEvents.ON_PROFILE_SUBSCRIPTION,
        parameters: {"type": subscriptionType});
  }

  static void onPreviewProfileEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_PREVIEW,
    );
  }

  static void onPublishProfileUpdatesEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_PUBLISH,
    );
  }

  /// Feature : PAYMENT
  static void onPaymentProceedEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PAYMENT_CONFIRM,
    );
  }

  static void onPaymentHistoryTabEvent(String tab) {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PAYMENT_HISTORY_TAB,
      parameters: {"tab": tab},
    );
  }

  /// Feature : Setting
  static void onSettingLogoutEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SETTING_LOGOUT_CLICKED,
    );
  }

  static void onSettingContactUsEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SETTING_CONTACT_US_CLICKED,
    );
  }

  static void onSettingFaqEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SETTING_FAQ_CLICKED,
    );
  }

  static void onSettingLocationNameProvidedEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SETTING_LOCATION_PROVIDED,
    );
  }

  //Todo: Fix in Phase 3
  static void onNotificationSettingsUpdateEvent() {
    _firebaseAnalyticsInstance.logEvent(
      name: "notification_settings",
    );
  }
}
