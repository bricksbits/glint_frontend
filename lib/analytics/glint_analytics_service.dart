import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:glint_frontend/analytics/glint_analytics_events.dart';

class GlintAnalyticService {
  static final _firebaseAnalyticsInstance = FirebaseAnalytics.instance;

  static void setAnalyticsEnable() {
    _firebaseAnalyticsInstance.setAnalyticsCollectionEnabled(true);
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

  static void forgotPasswordEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.FORGOT_PASSWORD,
    );
  }

  static void emailIdProvidedForForgotPasswordEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.FORGOT_PASSWORD_EMAIL_ID,
    );
  }

  static void otpProvidedForForgotPasswordEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.FORGOT_PASSWORD_OTP,
    );
  }

  static void newPasswordProvidedForForgotPasswordEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.FORGOT_PASSWORD_NEW_PASSWORD,
    );
  }

  static void registerSuccessfullyEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.CREATE_USER,
    );
  }

  /// Feature : ONBOARDING
  static void onBoardImageProvidedEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_BOARDING_IMAGES_PROVIDED,
    );
  }

  static void onBoardCompletedBioEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_BOARDING_BIO,
    );
  }

  static void onBoardNavigatedDirectlyEvent(String screenName) async {
    await _firebaseAnalyticsInstance.logEvent(
        name: GlintAnalyticsEvents.ON_BOARDING_NAVIDATE_DIRECTLY,
        parameters: {"screen": screenName});
  }

  static void onBoardLocationPermissionEvent(bool isPermissionGranted) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_BOARDING_LOCATION_PERMISSION,
      parameters: {"permission": isPermissionGranted ? "Granted" : "Rejected"},
    );
  }

  static void onNavItemClickedEvent(GlintNavItemAnalyticsEvents event) async {
    final navItemEventName = switch (event) {
      GlintNavItemAnalyticsEvents.PROFILE =>
        GlintAnalyticsEvents.ON_PROFILE_NAV,
      GlintNavItemAnalyticsEvents.EVENT => GlintAnalyticsEvents.ON_EVENT_NAV,
      GlintNavItemAnalyticsEvents.HOME => GlintAnalyticsEvents.ON_HOME_NAV,
      GlintNavItemAnalyticsEvents.CHAT => GlintAnalyticsEvents.ON_CHAT_NAV,
    };
    await _firebaseAnalyticsInstance.logEvent(
      name: navItemEventName,
    );
  }

  /// Feature: HOME SCREEN
  static void onCardActionEvent(
    GlintSwipeGestureAnalyticsEvents event,
    bool isPremiumUser,
  ) async {
    String cardEventActionName = switch (event) {
      GlintSwipeGestureAnalyticsEvents.RIGHT =>
        GlintAnalyticsEvents.ON_RIGHT_SWIPE,
      GlintSwipeGestureAnalyticsEvents.LEFT =>
        GlintAnalyticsEvents.ON_LEFT_SWIPE,
      GlintSwipeGestureAnalyticsEvents.SUPER =>
        GlintAnalyticsEvents.ON_SUPER_LIKE,
      GlintSwipeGestureAnalyticsEvents.DM => "super_dm",
    };

    await _firebaseAnalyticsInstance.logEvent(
      name: cardEventActionName,
      parameters: {"premium": isPremiumUser ? "Yes" : "No"},
    );
  }

  static void onRewindEvent(
    bool isPremiumUser,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_REWIND,
      parameters: {"premium": isPremiumUser ? "Yes" : "No"},
    );
  }

  static void onLikeScreenEvent(
    bool isPremiumUser,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_LIKE,
    );
  }

  static void onSearchScreenEvent(
    bool isPremiumUser,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SEARCH_SCREEN,
    );
  }

  static void onNotificationScreenEvent(
    bool isPremiumUser,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_NOTIFICATION_SCREEN,
    );
  }

  /// Feature : Notifications
  static void onNotificationItemClickedEvent(
    String notificationType,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_NOTIFICATION_ITEM,
      parameters: {"type": notificationType},
    );
  }

  static void onLikedItemClickedEvent(
    String oppositeUserId,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_LIKE_PROFILE_ITEM,
      parameters: {"opposite_id": oppositeUserId},
    );
  }

  /// Feature : Search
  static void onSearchApplyEvent(
    String distanceSelected,
    String ageSet,
    bool isLocationPermissionEnabled,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
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
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_CARD_CLICKED,
      parameters: {"event_id": eventId},
    );
  }

  static void onEventCardItemInfoClickedEvent(
    String eventId,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_CARD_INFO,
      parameters: {"event_id": eventId},
    );
  }

  // Recent or Nearby
  static void onEventFilterTabsEvent(
    String tab,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_FILTER_TAB_CLICKED,
      parameters: {
        "tab": tab,
      },
    );
  }

  // Events Or Explore
  static void onEventTabsEvent(
    String tab,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_TYPE_TAB_CLICKED,
      parameters: {
        "tab": tab,
      },
    );
  }

  static void onEventDetailsMapEvent(
    String eventId,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_MAP_CLICKED,
      parameters: {
        "event_id": eventId,
      },
    );
  }

  static void onEventDetailsImagesScrolledEvent(
    String eventId,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_IMAGES_SCROLLED,
      parameters: {
        "event_id": eventId,
      },
    );
  }

  static void onNoEventsInstaLinksClickedEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_TO_INSTA,
    );
  }

  static void onNoEventsWebsiteLinksClickedEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_EVENT_TO_WEBSITE,
    );
  }

  /// Feature : CHAT
  static void onUploadStoriesEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_UPLOAD_STORY,
    );
  }

  static void onUserThumbnailClickedEvent(
    String oppositeUserId,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_CHAT_PROFILE_CLICKED,
      parameters: {
        "opposite_id": oppositeUserId,
      },
    );
  }

  static void onVideoCallClickedEvent(
    String userId,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_CHAT_VIDEO_CALL_CLICKED,
      parameters: {
        "user_id": userId,
      },
    );
  }

  static void onSettingIconMenuClickedEvent(
    String userId,
    String oppositeId,
    String matchId,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_CHAT_SETTINGS_CLICKED,
      parameters: {
        "user_id": userId,
        "opposite_id": oppositeId,
        "match_id": matchId,
      },
    );
  }

  static void onMediaSelectedEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_CHAT_MEDIA_CLICKED,
    );
  }

  static void onRefreshHitEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_CHAT_REFRESH,
    );
  }

  /// Feature : PROFILE
  static void onProfileSettingsEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_SETTING,
    );
  }

  static void onTicketHistoryEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_TICKET_HISTORY,
    );
  }

  static void onEditProfileEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_EDIT,
    );
  }

  static void onVerificationProfileEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_VERIFICATION,
    );
  }

  static void onSubscriptionProfileEvent(
    String subscriptionType,
  ) async {
    await _firebaseAnalyticsInstance.logEvent(
        name: GlintAnalyticsEvents.ON_PROFILE_SUBSCRIPTION,
        parameters: {"type": subscriptionType});
  }

  static void onPreviewProfileEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_PREVIEW,
    );
  }

  static void onPublishProfileUpdatesEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PROFILE_PUBLISH,
    );
  }

  /// Feature : PAYMENT
  static void onPaymentProceedEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PAYMENT_CONFIRM,
    );
  }

  static void onPaymentHistoryTabEvent(String tab) async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_PAYMENT_HISTORY_TAB,
      parameters: {"tab": tab},
    );
  }

  /// Feature : Setting
  static void onSettingLogoutEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SETTING_LOGOUT_CLICKED,
    );
  }

  static void onSettingContactUsEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SETTING_CONTACT_US_CLICKED,
    );
  }

  static void onSettingFaqEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SETTING_FAQ_CLICKED,
    );
  }

  static void onSettingLocationNameProvidedEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: GlintAnalyticsEvents.ON_SETTING_LOCATION_PROVIDED,
    );
  }

  //Todo: Fix in Phase 3
  static void onNotificationSettingsUpdateEvent() async {
    await _firebaseAnalyticsInstance.logEvent(
      name: "notification_settings",
    );
  }
}
