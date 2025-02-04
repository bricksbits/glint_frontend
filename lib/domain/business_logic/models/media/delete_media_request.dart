class DeleteMediaRequest {
  final List<String>? picturesList;
  final List<String>? storyList;
  final List<String>? videoList;

  DeleteMediaRequest(this.picturesList, this.storyList, this.videoList);
}
