class PauseEventRequestBody {
  PauseEventRequestBody({required this.isPaused});

  final bool isPaused;

  Map<String, dynamic> toJson() => {'is_paused': isPaused};
}
