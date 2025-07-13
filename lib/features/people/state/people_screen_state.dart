import 'package:flutter/material.dart';
import 'package:glint_frontend/features/people/model/emojis_mega_map.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/features/people/model/scrollable_list_item_type.dart';

class PeopleScreenState {
  final List<PeopleListModelData> listModel;
  final PeopleTopCardModel topCardModel;

  PeopleScreenState(this.listModel, this.topCardModel);
}

extension ToPeopleScreenState on PeopleCardModel {
  PeopleScreenState convert() {
    final topCardModel = PeopleTopCardModel(
      userId,
      pictureUrlList.isNotEmpty ? pictureUrlList.first : '',
      // Added imageUrl from the first image
      username,
      age,
      distanceAway,
      profileViews ?? "",
      occupation ?? "",
    );

    List<PeopleListModelData> listModel = [];

    // Add other components first, then intersperse with images
    int componentIndex = 0;
    int imageIndex = 1;
    const int totalComponents = 5;

    while (
    componentIndex < totalComponents || imageIndex < pictureUrlList.length) {
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
      if (imageIndex < pictureUrlList.length) {
        listModel.add(PeopleListModelData(
          itemType: ScrollableListItemType.IMAGE,
          imageUrl: pictureUrlList[imageIndex],
        ));
        imageIndex++;
      }
    }

    return PeopleScreenState(listModel, topCardModel);
  }
}

PeopleScreenState convertPeopleUiModelToPeopleScreenState(
    PeopleCardModel uiModel) {
  final topCardModel = PeopleTopCardModel(
    uiModel.userId,
    uiModel.pictureUrlList.isNotEmpty ? uiModel.pictureUrlList.first : '',
    // Added imageUrl from the first image
    uiModel.username,
    uiModel.age,
    uiModel.distanceAway,
    uiModel.profileViews ?? "",
    uiModel.occupation,
  );

  List<PeopleListModelData> listModel = [];

  // Add other components first, then intersperse with images
  int componentIndex = 0;
  int imageIndex = 0;
  const int totalComponents = 5;

  while (
      componentIndex < totalComponents || imageIndex < uiModel.pictureUrlList.length) {
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
    if (imageIndex < uiModel.pictureUrlList.length) {
      listModel.add(PeopleListModelData(
        itemType: ScrollableListItemType.IMAGE,
        imageUrl: uiModel.pictureUrlList[imageIndex],
      ));
      imageIndex++;
    }
  }

  return PeopleScreenState(listModel, topCardModel);
}

List<Map<String, dynamic>> mapAboutSectionToIconTextList(Map<String, String> aboutSection) {
  final iconMapping = {
    'height': Icons.straighten,
    'workoutHabits': Icons.fitness_center,
    'drinkingHabits': Icons.local_bar,
    'smokingHabits': Icons.smoking_rooms,
  };

  List<Map<String, dynamic>> result = [];

  aboutSection.forEach((key, value) {
    if (value.isNotEmpty && iconMapping.containsKey(key)) {
      result.add({
        'icon': iconMapping[key],
        'text': value,
      });
    }
  });

  return result;
}

List<Map<String, String>> mapInterestsToLabelIconList({
  required List<String> userInterests,
}) {
  return userInterests
      .map((interest) =>
  interest[0].toUpperCase() + interest.substring(1).toLowerCase())
      .where((capitalizedInterest) => interestEmojisMap.containsKey(capitalizedInterest))
      .map((capitalizedInterest) => {
    'label': capitalizedInterest,
    'icon': interestEmojisMap[capitalizedInterest]!,
  })
      .toList();
}

