import 'dart:io';

import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';

class EventDetailsNavArguments {
  final int? eventId;
  final EventDetailsDomainModel? eventDetails;
  final List<File?>? unUploadedFiles;

  EventDetailsNavArguments({
    required this.eventId,
    required this.eventDetails,
    required this.unUploadedFiles,
  });
}

class AdminCreateEventNavArguments {
  final int? updateExistingEventId;
  final Function(String) onReturn;

  AdminCreateEventNavArguments(this.updateExistingEventId, this.onReturn);
}

class ToEventPeopleScreenNavArguments {
  final int? eventId;
  final String? eventName;
  final String? eventDaysLeft;

  ToEventPeopleScreenNavArguments({
    required this.eventId,
    required this.eventName,
    required this.eventDaysLeft,
  });
}

class ChatWithNavArguments {
  final String channelId;
  final String? eventId;
  final String? eventName;
  final String? eventStartTime;
  final String? matchId;

  ChatWithNavArguments({
    required this.channelId,
    this.eventId,
    this.eventName,
    this.eventStartTime,
    this.matchId,
  });
}

class OneTimeViewNavArguments {
  final String? imageUrl;
  final String? message;

  OneTimeViewNavArguments(this.imageUrl, this.message);
}

class ConfirmTicketNavArguments {
  final String eventId;
  final String matchId;
  final UserTicketHolderModel? matchedUser;
  final String totalAmount;

  ConfirmTicketNavArguments({
    required this.eventId,
    required this.matchId,
    this.matchedUser,
    required this.totalAmount,
  });
}
