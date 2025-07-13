import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/people/exports.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/features/people/model/scrollable_list_item_type.dart';
import 'package:glint_frontend/features/people/state/people_screen_state.dart';

class ScrollableProfileView extends StatelessWidget {
  final PeopleCardModel peopleUiModel;
  final Function(String) onLiked;
  final Function(String) onDisLiked;
  final Function(String) onDm;
  final Function(String) onSuperLiked;

  const ScrollableProfileView({
    super.key,
    required this.peopleUiModel,
    required this.onLiked,
    required this.onDisLiked,
    required this.onDm,
    required this.onSuperLiked,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColours.white,
      body: CustomScrollView(
        slivers: <Widget>[
          // Top Card Sliver
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TopProfileCard(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                imageUrl: peopleUiModel.convert().topCardModel.imageUrl,
                recentActive: "New",
                shareProfile: () {},
                designation: peopleUiModel.occupation,
                sendMessage: () {},
                sendSuperLike: () {},
              ),
            ),
          ),

          const SliverGap(8.0),

          // List of Items Sliver
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    const Gap(32.0),
                    buildListItem(
                      peopleUiModel.convert().listModel[index],
                      screenWidth,
                      screenHeight,
                      peopleUiModel.username,
                    )
                  ],
                );
              },
              childCount: peopleUiModel.convert().listModel.length,
            ),
          ),

          const SliverToBoxAdapter(
            child: ScrollableProfileFooter(),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(
    PeopleListModelData item,
    double screenHeight,
    double screenWidth,
    String userName,
  ) {
    switch (item.itemType) {
      case ScrollableListItemType.IMAGE:
        return item.imageUrl != null
            ? ProfileCard(
                imageUrl: item.imageUrl ?? "",
                sendMessage: () {},
                sendSuperLike: () {},
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              )
            : const SizedBox.shrink(); // Handle null imageUrl
      case ScrollableListItemType.ABOUT:
        return item.about != null
            ? ProfileCardAboutBox(
                title: 'About',
                tags: mapAboutSectionToIconTextList(item.about!),
                name: userName,
              )
            : const SizedBox.shrink();
      case ScrollableListItemType.BIO:
        return item.bio != null
            ? ProfileCardBioBox(
                content: item.bio!,
              )
            : const SizedBox.shrink();
      case ScrollableListItemType.LOOKING_FOR:
        return item.lookingFor != null
            ? ProfileCardLookingForBox(lookingFor: item.lookingFor!)
            : const SizedBox.shrink();
      case ScrollableListItemType.INTEREST:
        return item.interests != null
            ? ProfileInterestVibeBox(
                interests: mapInterestsToLabelIconList(
                  userInterests: item.interests!,
                ),
              )
            : const SizedBox.shrink();
      case ScrollableListItemType.LOCATION:
        return item.location != null
            ? ProfileLocationBox(
                location: item.location!,
                distance: "Near you",
              )
            : const SizedBox.shrink();
    }
  }
}
