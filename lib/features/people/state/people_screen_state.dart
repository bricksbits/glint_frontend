import 'package:glint_frontend/features/people/model/people_model.dart';
import 'package:glint_frontend/features/people/model/scrollable_list_item_type.dart';

class PeopleScreenState {
  final List<PeopleListModelData> listModel;
  final PeopleTopCardModel topCardModel;

  PeopleScreenState(this.listModel, this.topCardModel);
}

extension ToPeopleScreenState on PeopleUiModel {
  PeopleScreenState convert() {
    final topCardModel = PeopleTopCardModel(
      userId,
      images.isNotEmpty ? images.first : '',
      // Added imageUrl from the first image
      name,
      age,
      distanceAway,
      profileViews,
      designation,
    );

    List<PeopleListModelData> listModel = [];

    // Add other components first, then intersperse with images
    int componentIndex = 0;
    int imageIndex = 1;
    const int totalComponents = 5;

    while (
    componentIndex < totalComponents || imageIndex < images.length) {
      // Add component (if available)
      if (componentIndex < totalComponents) {
        switch (componentIndex) {
          case 0:
            if (about.isNotEmpty) {
              listModel.add(
                PeopleListModelData(
                  itemType: ScrollableListItemType.ABOUT,
                  about: about,
                ),
              );
            }
            break;
          case 1:
            if (bio.isNotEmpty) {
              listModel.add(PeopleListModelData(
                itemType: ScrollableListItemType.BIO,
                bio: bio,
              ));
            }
            break;
          case 2:
            if (lookingFor.isNotEmpty) {
              listModel.add(PeopleListModelData(
                itemType: ScrollableListItemType.LOOKING_FOR,
                lookingFor: lookingFor,
              ));
            }
            break;
          case 3:
            if (interests.isNotEmpty) {
              listModel.add(PeopleListModelData(
                itemType: ScrollableListItemType.INTEREST,
                interests: interests,
              ));
            }
            break;
          case 4:
            if (location.isNotEmpty) {
              listModel.add(PeopleListModelData(
                itemType: ScrollableListItemType.LOCATION,
                location: location,
              ));
            }
            break;
        }
        componentIndex++;
      }

      // Add image (if available)
      if (imageIndex < images.length) {
        listModel.add(PeopleListModelData(
          itemType: ScrollableListItemType.IMAGE,
          imageUrl: images[imageIndex],
        ));
        imageIndex++;
      }
    }

    return PeopleScreenState(listModel, topCardModel);
  }
}

PeopleScreenState convertPeopleUiModelToPeopleScreenState(
    PeopleUiModel uiModel) {
  final topCardModel = PeopleTopCardModel(
    uiModel.userId,
    uiModel.images.isNotEmpty ? uiModel.images.first : '',
    // Added imageUrl from the first image
    uiModel.name,
    uiModel.age,
    uiModel.distanceAway,
    uiModel.profileViews,
    uiModel.designation,
  );

  List<PeopleListModelData> listModel = [];

  // Add other components first, then intersperse with images
  int componentIndex = 0;
  int imageIndex = 0;
  const int totalComponents = 5;

  while (
      componentIndex < totalComponents || imageIndex < uiModel.images.length) {
    // Add component (if available)
    if (componentIndex < totalComponents) {
      switch (componentIndex) {
        case 0:
          if (uiModel.about.isNotEmpty) {
            listModel.add(
              PeopleListModelData(
                itemType: ScrollableListItemType.ABOUT,
                about: uiModel.about,
              ),
            );
          }
          break;
        case 1:
          if (uiModel.bio.isNotEmpty) {
            listModel.add(PeopleListModelData(
              itemType: ScrollableListItemType.BIO,
              bio: uiModel.bio,
            ));
          }
          break;
        case 2:
          if (uiModel.lookingFor.isNotEmpty) {
            listModel.add(PeopleListModelData(
              itemType: ScrollableListItemType.LOOKING_FOR,
              lookingFor: uiModel.lookingFor,
            ));
          }
          break;
        case 3:
          if (uiModel.interests.isNotEmpty) {
            listModel.add(PeopleListModelData(
              itemType: ScrollableListItemType.INTEREST,
              interests: uiModel.interests,
            ));
          }
          break;
        case 4:
          if (uiModel.location.isNotEmpty) {
            listModel.add(PeopleListModelData(
              itemType: ScrollableListItemType.LOCATION,
              location: uiModel.location,
            ));
          }
          break;
      }
      componentIndex++;
    }

    // Add image (if available)
    if (imageIndex < uiModel.images.length) {
      listModel.add(PeopleListModelData(
        itemType: ScrollableListItemType.IMAGE,
        imageUrl: uiModel.images[imageIndex],
      ));
      imageIndex++;
    }
  }

  return PeopleScreenState(listModel, topCardModel);
}
