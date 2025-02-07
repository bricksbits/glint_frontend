class UpdateUserLocationRequest {
  final String userId;
  final String lat;
  final String long;

  UpdateUserLocationRequest({
    required this.userId,
    required this.lat,
    required this.long,
  });
}
