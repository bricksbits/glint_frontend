import 'package:flutter/cupertino.dart';

enum GlintMainRoutes {
  splash,
  auth,
  onBoarding,
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
  register,
  resetPassword,
  otp,
  recreatePassword,
  passwordSuccess
}

enum GlintChatRoutes {
  chatWith,
  videoCall,
  tickets,
  getTicket,
}

enum GlintEventRoutes {
  eventDetails,
  peopleInterested,
  explore,
}

enum GlintProfileRoutes {
  profilePreview,
  editProfile,
  ticketHistory,
  subscription,
  settings,
}

enum GlintBoardingRoutes {
  name,
  dob,
  gender,
  interestedGender,
  media,
  pronouns,
  interests,
  bio,
}

enum GlintAdminDasboardRoutes {
  splash,
  auth,
  home,
  createEvent,
  previewEvent,
  trackEvent,
  liveEvent,
  interestedUsers,
  ticketBought,
  profile,
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
