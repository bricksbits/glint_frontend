enum GlintMainRoutes {
  splash,
  auth,
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
}

enum GlintEventRoutes {
  eventDetails,
  peopleInterested,
  explore,
}

//Todo(Nike): Divide this into onBoarding and Profile Screens
enum GlintProfileRoutes {
  profilePreview,
  ticketHistory,
  transactionHistory,
  editProfile,
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
