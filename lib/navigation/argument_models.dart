import 'dart:io';

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
