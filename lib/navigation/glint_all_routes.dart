import 'package:flutter/cupertino.dart';

enum GlintMainRoutes {
  splash,
  starter,
  auth,
  onBoarding,
  register,
  home,
  chat,
  service,
  people,
  event,
  profile,
  notifications,
  likes,
  filter,
  payment,
  subscriptions,
  settings,
  history,
}

enum GlintAuthRoutes {
  resetPassword,
  otp,
  recreatePassword,
  passwordSuccess
}

enum GlintChatRoutes {
  chatWith,
  stories,
  videoCall,
  ticket,
  getTicket,
  uploadStory,
  oneTimePhotoView,
}

enum GlintEventRoutes {
  eventDetails,
  peopleInterested,
  tickets,
}

enum GlintProfileRoutes {
  profilePreview,
  editProfile,
  paymentHistory,
}

enum GlintBoardingRoutes {
  boarding,
  name,
  dob,
  gender,
  interestedGender,
  media,
  pronouns,
  interests,
  bio,
  location,
}

enum GlintAdminDasboardRoutes {
  adminHome,
  adminPublishedEvents,
  createEvent,
  previewEvent,
  trackEvent,
  interestedUsers,
  ticketBought,
  liveEvent,

  authProfile,
  superAdminHome,
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> onBoardingKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> trackAdminEventKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> profileKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> adminDashboardKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> chatKey = GlobalKey<NavigatorState>();
