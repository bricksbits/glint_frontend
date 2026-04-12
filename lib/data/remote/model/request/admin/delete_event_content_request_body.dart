class DeleteEventContentRequestBody {
  DeleteEventContentRequestBody({
    required this.pictureList,
    required this.videoList,
  });

  final List<String> pictureList;
  final List<String> videoList;

  Map<String, dynamic> toJson() => {
        'picture_list': pictureList,
        'video_list': videoList,
      };
}
