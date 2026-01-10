class GlintAnalyticsEvents {

  // Authentication
  static String LOGIN_USER = "logged_in";
  static String FORGOT_PASSWORD = "forgot_password";
  static String FORGOT_PASSWORD_EMAIL_ID = "forgot_password_email";
  static String FORGOT_PASSWORD_OTP = "forgot_password_otp";
  static String FORGOT_PASSWORD_NEW_PASSWORD = "forgot_password_new_password";
  static String CREATE_USER = "sign_in";


  // OnBoarding
  static String ON_BOARDING_IMAGES_PROVIDED = "boarding_images";
  static String ON_BOARDING_BIO = "boarding_bio";
  static String ON_BOARDING_RESET = "boarding_reset";
  static String ON_BOARDING_NAVIDATE_DIRECTLY = "boarding_navigating_to";
  static String ON_BOARDING_LOCATION_PERMISSION = "boarding_location_perm";

  // People Screen
  static String ON_RIGHT_SWIPE = "right_swipe";
  static String ON_LEFT_SWIPE = "left_swipe";
  static String ON_SUPER_LIKE = "super_like";
  static String ON_REWIND = "rewind";
  static String ON_LIKE = "like";
  static String ON_DISLIKE = "dislike";
  static String ON_LIKED_SCREEN = "to_like";
  static String ON_SEARCH_SCREEN = "to_search";
  static String ON_NOTIFICATION_SCREEN = "to_notification";
  static String ON_HOME_NAV = "home_nav";

  // Notifications
  static String ON_NOTIFICATION_ITEM = "notification_clicked";

  // Like
  static String ON_LIKE_PROFILE_ITEM = "like_profile_clicked";

  // Search
  static String ON_SEARCH_APPLY = "search_profile";
  static String ON_SEARCH_PERMISSION = "search_location_perm";

  // Events
  static String ON_EVENT_CARD_CLICKED = "event_card_clicked";
  static String ON_EVENT_CARD_INFO = "event_card_info_clicked";
  static String ON_EVENT_FILTER_TAB_CLICKED = "event_card_filter_clicked";
  static String ON_EVENT_TYPE_TAB_CLICKED = "event_card_type_clicked";
  static String ON_EVENT_MAP_CLICKED = "event_map_clicked";
  static String ON_EVENT_IMAGES_SCROLLED = "event_images_scrolled";
  static String ON_EVENT_TO_INSTA = "event_to_instagram";
  static String ON_EVENT_TO_WEBSITE = "event_to_website";
  static String ON_EVENT_NAV = "event_nav";

  // Chat
  static String ON_UPLOAD_STORY = "upload_story_clicked";
  static String ON_CHAT_ITEM_CLICKED = "chat_with_clicked";
  static String ON_CHAT_PROFILE_CLICKED = "chat_profile_clicked";
  static String ON_CHAT_VIDEO_CALL_CLICKED = "chat_video_call_clicked";
  static String ON_CHAT_SETTINGS_CLICKED = "chat_settings_clicked";
  static String ON_CHAT_MEDIA_CLICKED = "chat_send_media_clicked";
  static String ON_CHAT_REFRESH = "chat_refresh";
  static String ON_CHAT_NAV = "chat_nav";

  // Profile
  static String ON_PROFILE_SETTING = "profile_setting_clicked";
  static String ON_PROFILE_TICKET_HISTORY = "profile_ticket_history_clicked";
  static String ON_PROFILE_EDIT = "profile_edit_clicked";
  static String ON_PROFILE_VERIFICATION = "profile_verification_clicked";
  static String ON_PROFILE_SUBSCRIPTION = "profile_subscription_clicked";
  static String ON_PROFILE_PREVIEW = "profile_preview_clicked";
  static String ON_PROFILE_PUBLISH = "profile_publish_clicked";
  static String ON_PROFILE_NAV = "profile_nav";

  // Payment History
  static String ON_PAYMENT_HISTORY_TAB = "payment_history_tab";

  // Payment
  static String ON_PAYMENT_CONFIRM = "payment_confirm_clicked";

  // Settings
  static String ON_SETTING_LOGOUT_CLICKED = "logout_clicked";
  static String ON_SETTING_CONTACT_US_CLICKED = "contact_us_clicked";
  static String ON_SETTING_FAQ_CLICKED = "faq_clicked";
  static String ON_SETTING_LOCATION_PROVIDED = "settings_location_provided";

}


enum GlintSwipeGestureAnalyticsEvents {
  RIGHT,
  LEFT,
  SUPER,
  DM,
}

enum GlintNavItemAnalyticsEvents {
  PROFILE,
  EVENT,
  HOME,
  CHAT,
}