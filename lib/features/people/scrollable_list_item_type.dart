enum ScrollableListItemType {
  IMAGE,
  ABOUT,
  BIO,
  LOOKING_FOR,
  INTERETS,
  LOCATION,
}

class PeopleListModelData {
  final ScrollableListItemType itemType;
  final List<String>? about;
  final String? bio;
  final List<String>? lookingFor;
  final List<String>? interests;
  final String location;

  PeopleListModelData(
    this.itemType,
    this.about,
    this.bio,
    this.lookingFor,
    this.interests,
    this.location,
  );
}

class PeopleTopCardModel {
  final String id;
  final String name;
  final String age;
  final String locationAway;
  final String views;
  final String designation;

  PeopleTopCardModel(
    this.id,
    this.name,
    this.age,
    this.locationAway,
    this.views,
    this.designation,
  );
}
