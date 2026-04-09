class NotificationHistoryItem {
  final int id;
  final String type;
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final bool isRead;
  final DateTime createdAt;

  const NotificationHistoryItem({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.data,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationHistoryItem.fromJson(Map<String, dynamic> json) {
    return NotificationHistoryItem(
      id: json['id'] as int,
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>? ?? {},
      isRead: json['is_read'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

class NotificationHistoryResponse {
  final List<NotificationHistoryItem> notifications;
  final int unreadCount;

  const NotificationHistoryResponse({
    required this.notifications,
    required this.unreadCount,
  });

  factory NotificationHistoryResponse.fromJson(Map<String, dynamic> json) {
    // Unwrap a `data` envelope if the server wraps the response
    final body = json['data'] as Map<String, dynamic>? ?? json;
    final rawList = body['notifications'] as List<dynamic>? ?? [];
    return NotificationHistoryResponse(
      notifications: rawList
          .map((e) => NotificationHistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      unreadCount: body['unread_count'] as int? ?? 0,
    );
  }
}
