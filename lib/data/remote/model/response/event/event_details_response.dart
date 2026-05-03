import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/utils/date_and_time_extensions.dart';

class EventDetailsUserResponse {
  final int? coordinatorUserId;
  final String? coordinatorUserPhoneNumber;
  final String? coordinatorUserUsername;
  final String? eventName;
  final String? eventDescription;
  final String? eventLocationName;
  final int? ticketPrice;
  final int? discountTicketPrice;
  final bool? discountActivated;
  final int? ticketsBought;
  final int? interestedUsersCount;
  final double? eventLongitude;
  final double? eventLatitude;
  final String? startTime;
  final String? endTime;
  final List<EventPictureUrl>? pictureUrlList;
  final List<String>? videoUrlList;
  final bool? isPaused;

  EventDetailsUserResponse.fromJson(dynamic json)
      : coordinatorUserId = json['coordinator_user_id'],
        coordinatorUserPhoneNumber = json['coordinator_user_phone_number'],
        coordinatorUserUsername = json['coordinator_user_username'],
        eventName = json['event_name'],
        eventDescription = json['event_description'],
        eventLocationName = json['event_location_name'],
        ticketPrice = json['ticket_price'],
        discountTicketPrice = json['discount_ticket_price'],
        discountActivated = json['discount_activated'],
        ticketsBought = json['tickets_bought'],
        interestedUsersCount = json['interested_users_count'],
        eventLongitude = (json['event_longitude'] as num?)?.toDouble(),
        eventLatitude = (json['event_latitude'] as num?)?.toDouble(),
        startTime = json['start_time'],
        endTime = json['end_time'],
        pictureUrlList = json['picture_url_list'] != null
            ? (json['picture_url_list'] as List)
                .map((v) => EventPictureUrl.fromJson(v))
                .toList()
            : null,
        videoUrlList = json['video_url_list'] != null
            ? (json['video_url_list'] as List).cast<String>()
            : [],
        isPaused = json['is_paused'];
}

class EventDetailsAdminResponse {
  final int? eventId;
  final String? eventName;
  final String? eventBy;
  final String? eventDescription;
  final String? googleMapUrl;
  final double? locationLongitude;
  final double? locationLatitude;
  final String? eventLocationName;
  final String? createdTime;
  final String? bookByTime;
  final String? startTime;
  final String? endTime;
  final int? ticketPrice;
  final int? discountTicketPrice;
  final bool? discountActivated;
  final int? totalTickets;
  final int? ticketsRemaining;
  final List<String>? categoryList;
  final String? approvedByAdmin;
  final bool? isHotEvent;
  final bool? isPaused;
  final int? coordinatorUserId;
  final String? coordinatorUsername;
  final String? coordinatorEmail;
  final int? interestedCount;
  final int? confirmedTicketsCount;
  final List<EventPictureUrl>? pictureUrlList;
  final List<String>? videoUrlList;

  EventDetailsAdminResponse.fromJson(dynamic json)
      : eventId = json['event_id'],
        eventName = json['event_name'],
        eventBy = json['event_by'],
        eventDescription = json['event_description'],
        googleMapUrl = json['google_map_url'],
        locationLongitude = (json['location_longitude'] as num?)?.toDouble(),
        locationLatitude = (json['location_latitude'] as num?)?.toDouble(),
        eventLocationName = json['event_location_name'],
        createdTime = json['created_time'],
        bookByTime = json['book_by_time'],
        startTime = json['start_time'],
        endTime = json['end_time'],
        ticketPrice = json['ticket_price'],
        discountTicketPrice = json['discount_ticket_price'],
        discountActivated = json['discount_activated'],
        totalTickets = json['total_tickets'],
        ticketsRemaining = json['tickets_remaining'],
        categoryList = json['category_list'] != null
            ? (json['category_list'] as List).cast<String>()
            : null,
        approvedByAdmin = json['approved_by_admin'],
        isHotEvent = json['is_hot_event'],
        isPaused = json['is_paused'],
        coordinatorUserId = json['coordinator_user_id'],
        coordinatorUsername = json['coordinator_username'],
        coordinatorEmail = json['coordinator_email'],
        interestedCount = json['interested_count'],
        confirmedTicketsCount = json['confirmed_tickets_count'],
        pictureUrlList = json['picture_url_list'] != null
            ? (json['picture_url_list'] as List)
                .map((v) => EventPictureUrl.fromJson(v))
                .toList()
            : null,
        videoUrlList = json['video_url_list'] != null
            ? (json['video_url_list'] as List).cast<String>()
            : [];
}

class EventPictureUrl {
  final String? presignedUrl;
  final String? fileExtension;

  EventPictureUrl.fromJson(dynamic json)
      : presignedUrl = json['presigned_url'],
        fileExtension = json['file_extension'];
}

DateTime _parseEventTime(String? time) {
  if (time == null) return DateTime.now();
  try {
    return DateTime.parse(time);
  } catch (_) {
    try {
      return DateTime.parse(time.replaceAll(' +0000 UTC', 'Z'));
    } catch (_) {
      return DateTime.now();
    }
  }
}

String _daysBetween(DateTime start) {
  final diff = start.toUtc().difference(DateTime.now().toUtc()).inDays;
  return diff.toString();
}

List<String> _extractImageUrls(List<EventPictureUrl>? list) {
  return list
          ?.where((p) => p.presignedUrl != null)
          .map((p) => p.presignedUrl!)
          .toList() ??
      [];
}

class EventDetailsResponseWrapper {
  final EventDetailsUserResponse? _userResponse;
  final EventDetailsAdminResponse? _adminResponse;

  bool get isAdminResponse => _adminResponse != null;

  EventDetailsResponseWrapper._user(this._userResponse) : _adminResponse = null;

  EventDetailsResponseWrapper._admin(this._adminResponse)
      : _userResponse = null;

  factory EventDetailsResponseWrapper.fromJson(dynamic json) {
    // Admin response always carries 'event_id'; user response does not.
    if (json['event_id'] != null) {
      return EventDetailsResponseWrapper._admin(
        EventDetailsAdminResponse.fromJson(json),
      );
    }
    return EventDetailsResponseWrapper._user(
      EventDetailsUserResponse.fromJson(json),
    );
  }

  EventDetailsDomainModel mapToDomain() {
    return isAdminResponse
        ? _mapAdmin(_adminResponse!)
        : _mapUser(_userResponse!);
  }

  EventDetailsDomainModel _mapUser(EventDetailsUserResponse r) {
    final start = _parseEventTime(r.startTime);
    final end = _parseEventTime(r.endTime);
    return EventDetailsDomainModel(
      eventId: r.coordinatorUserId?.toString() ?? "",
      eventName: r.eventName ?? "",
      eventCoverImageUrl: _extractImageUrls(r.pictureUrlList),
      eventdate: start.toFormattedDate(),
      eventTime: end.toFormattedTime(),
      eventLocation: r.eventLocationName ?? "",
      eventOldPrice: r.ticketPrice?.toString() ?? "",
      eventCurrentPrice: r.discountActivated == true
          ? (r.discountTicketPrice?.toString() ??
              r.ticketPrice?.toString() ??
              "")
          : (r.ticketPrice?.toString() ?? ""),
      daysLeft: _daysBetween(start),
      peopleInterested: r.interestedUsersCount ?? 0,
      aboutEvent: r.eventDescription ?? "",
      location: {
        "lat": r.eventLatitude?.toString() ?? "0",
        "long": r.eventLongitude?.toString() ?? "0",
      },
      eventBy:
          "${r.coordinatorUserUsername}, - ${r.coordinatorUserPhoneNumber}",
      isPaused: r.isPaused ?? false,
      discountActivated: r.discountActivated ?? false,
      ticketsBought: r.ticketsBought,
      coordinatorUsername: r.coordinatorUserUsername,
      startDateTime: start,
      endDateTime: end,
    );
  }

  EventDetailsDomainModel _mapAdmin(EventDetailsAdminResponse r) {
    final start = _parseEventTime(r.startTime);
    final end = _parseEventTime(r.endTime);
    return EventDetailsDomainModel(
      eventId: r.eventId?.toString() ?? "",
      eventName: r.eventName ?? "",
      eventCoverImageUrl: _extractImageUrls(r.pictureUrlList),
      eventdate: start.toFormattedDate(),
      eventTime: end.toFormattedTime(),
      eventLocation: r.eventLocationName ?? "",
      eventOldPrice: r.ticketPrice?.toString() ?? "",
      eventCurrentPrice: r.discountActivated == true
          ? (r.discountTicketPrice?.toString() ??
              r.ticketPrice?.toString() ??
              "")
          : (r.ticketPrice?.toString() ?? ""),
      daysLeft: _daysBetween(start),
      peopleInterested: r.interestedCount ?? 0,
      aboutEvent: r.eventDescription ?? "",
      location: {
        "lat": r.locationLatitude?.toString() ?? "0",
        "long": r.locationLongitude?.toString() ?? "0",
      },
      eventBy: "${r.eventBy}, - ${r.coordinatorUsername}",
      isPaused: r.isPaused ?? false,
      discountActivated: r.discountActivated ?? false,
      coordinatorUsername: r.coordinatorUsername,
      startDateTime: start,
      endDateTime: end,
      googleMapUrl: r.googleMapUrl,
      bookByTime: r.bookByTime != null ? _parseEventTime(r.bookByTime) : null,
      totalTickets: r.totalTickets,
      ticketsRemaining: r.ticketsRemaining,
      categories: r.categoryList,
      approvalStatus: r.approvedByAdmin,
      isHotEvent: r.isHotEvent,
      coordinatorEmail: r.coordinatorEmail,
      interestedCount: r.interestedCount,
      confirmedTicketsCount: r.confirmedTicketsCount,
    );
  }
}
