class PaymentArgumentModel {
  // Membership
  final MembershipType? membershipType;
  final String? amountOfSelectedMembership;
  final String? timePeriod;

  // Events
  final String? eventId;
  final String? matchId;
  final UserTicketHolderModel? userOne;
  final UserTicketHolderModel? userTwo;
  final String? eventTicketPrice;

  PaymentArgumentModel({
    required this.membershipType,
    required this.amountOfSelectedMembership,
    required this.timePeriod,
    required this.eventId,
    required this.matchId,
    required this.userOne,
    required this.userTwo,
    required this.eventTicketPrice,
  });
}

enum MembershipType {
  GOLD,
  PLATINUM,
}

class UserTicketHolderModel {
  final String userId;
  final String username;
  final String imageUrl;

  UserTicketHolderModel({
    required this.userId,
    required this.username,
    required this.imageUrl,
  });
}
