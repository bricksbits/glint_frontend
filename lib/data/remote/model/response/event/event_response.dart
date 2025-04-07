class Event {
  final int eventId;
  final String eventName;
  final bool isHotEvent;
  final double? locationLongitude;
  final double? locationLatitude;
  final TimeRemaining timeRemaining;
  final int ticketPrice;
  final String pictureUrl;

  Event({
    required this.eventId,
    required this.eventName,
    required this.isHotEvent,
    this.locationLongitude,
    this.locationLatitude,
    required this.timeRemaining,
    required this.ticketPrice,
    required this.pictureUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['event_id'],
      eventName: json['event_name'],
      isHotEvent: json['is_hot_event'],
      locationLongitude: json['location_longitude']?.toDouble(),
      locationLatitude: json['location_latitude']?.toDouble(),
      timeRemaining: TimeRemaining.fromJson(json['time_remaining']),
      ticketPrice: json['ticket_price'],
      pictureUrl: json['picture_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'event_name': eventName,
      'is_hot_event': isHotEvent,
      'location_longitude': locationLongitude,
      'location_latitude': locationLatitude,
      'time_remaining': timeRemaining.toJson(),
      'ticket_price': ticketPrice,
      'picture_url': pictureUrl,
    };
  }
}

class TimeRemaining {
  final int microseconds;
  final int days;
  final int months;
  final bool valid;

  TimeRemaining({
    required this.microseconds,
    required this.days,
    required this.months,
    required this.valid,
  });

  factory TimeRemaining.fromJson(Map<String, dynamic> json) {
    return TimeRemaining(
      microseconds: json['Microseconds'],
      days: json['Days'],
      months: json['Months'],
      valid: json['Valid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Microseconds': microseconds,
      'Days': days,
      'Months': months,
      'Valid': valid,
    };
  }
}
