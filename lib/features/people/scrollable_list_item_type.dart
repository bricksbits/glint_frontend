enum ScrollableListItemType {
  IMAGE,
  ABOUT,
  BIO,
  LOOKING_FOR,
  INTEREST,
  LOCATION,
}

class PeopleListModelData {
  final ScrollableListItemType itemType;
  final List<String>? about;
  final String? bio;
  final List<String>? lookingFor;
  final List<String>? interests;
  final String? location;
  final String? imageUrl;

  PeopleListModelData(
      {required this.itemType,
      this.about,
      this.bio,
      this.lookingFor,
      this.interests,
      this.location,
      this.imageUrl});
}

class PeopleTopCardModel {
  final String id;
  final String name;
  final String age;
  final String locationAway;
  final String views;
  final String designation;
  final String imageUrl;

  PeopleTopCardModel(
    this.id,
    this.imageUrl,
    this.name,
    this.age,
    this.locationAway,
    this.views,
    this.designation,
  );
}
