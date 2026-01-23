class UniversalSuccessResponseBody<T> {
  final bool success;
  final String message;
  final T? data;

  UniversalSuccessResponseBody({
    required this.success,
    required this.message,
    this.data,
  });

  factory UniversalSuccessResponseBody.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return UniversalSuccessResponseBody<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
