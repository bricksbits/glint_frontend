import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/people/profile_card.dart';
import 'package:glint_frontend/design/components/people/profile_card_bio_box.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_footer.dart';
import 'package:glint_frontend/design/components/people/top_profile_card.dart';
import 'package:glint_frontend/features/people/model/people_model.dart';
import 'package:glint_frontend/features/people/scrollable_list_item_type.dart';
import 'package:glint_frontend/features/people/state/people_screen_state.dart';

//TODO(Nike): Use proper Exports
class ScrollableProfileView extends StatelessWidget {
  // final Map<String, dynamic> profileData;
  final peopleUiModel = PeopleUiModel(
    '5',
    'Ethan White',
    '40',
    '7.2 km',
    '950',
    'Project Manager',
    ['Experienced in agile methodologies', 'Strong leadership skills'],
    'A project manager dedicated to delivering projects on time and within budget.',
    ['Team building', 'Project management opportunities'],
    'Chicago, IL',
    ['Management', 'Sports', 'Cooking'],
    [
      'https://fastly.picsum.photos/id/960/200/300.jpg?hmac=lMLI27rQoFOVbWUEFQBILnVA_jFYw2b8KHACIGkDLD4',
      'https://fastly.picsum.photos/id/960/200/300.jpg?hmac=lMLI27rQoFOVbWUEFQBILnVA_jFYw2b8KHACIGkDLD4',
      'https://fastly.picsum.photos/id/960/200/300.jpg?hmac=lMLI27rQoFOVbWUEFQBILnVA_jFYw2b8KHACIGkDLD4',
      'https://fastly.picsum.photos/id/960/200/300.jpg?hmac=lMLI27rQoFOVbWUEFQBILnVA_jFYw2b8KHACIGkDLD4',
      'https://fastly.picsum.photos/id/960/200/300.jpg?hmac=lMLI27rQoFOVbWUEFQBILnVA_jFYw2b8KHACIGkDLD4',
      'https://fastly.picsum.photos/id/960/200/300.jpg?hmac=lMLI27rQoFOVbWUEFQBILnVA_jFYw2b8KHACIGkDLD4',
      'https://fastly.picsum.photos/id/960/200/300.jpg?hmac=lMLI27rQoFOVbWUEFQBILnVA_jFYw2b8KHACIGkDLD4',
      'https://fastly.picsum.photos/id/960/200/300.jpg?hmac=lMLI27rQoFOVbWUEFQBILnVA_jFYw2b8KHACIGkDLD4',
      'https://fastly.picsum.photos/id/960/200/300.jpg?hmac=lMLI27rQoFOVbWUEFQBILnVA_jFYw2b8KHACIGkDLD4',
    ],
  );

  ScrollableProfileView({super.key});

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
            child: TopProfileCard(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              imageUrl: peopleUiModel.convert().topCardModel.imageUrl,
              recentActive: "New",
              shareProfile: () {},
              designation: "Fashion Designer",
              sendMessage: () {},
              sendSuperLike: () {},
            ),
          ),

          // List of Items Sliver
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return buildListItem(peopleUiModel.convert().listModel[index],
                    screenWidth, screenHeight);
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
            ? const ProfileCardBioBox(
                content: 'Hey there, just a chill person here')
            : const SizedBox.shrink();
      case ScrollableListItemType.BIO:
        return item.bio != null
            ? const ProfileCardBioBox(
                content: 'Hey there, just a chill person here')
            : const SizedBox.shrink();
      case ScrollableListItemType.LOOKING_FOR:
        return item.lookingFor != null
            ? const ProfileCardBioBox(
                content: 'Hey there, just a chill person here')
            : const SizedBox.shrink();
      case ScrollableListItemType.INTEREST:
        return item.interests != null
            ? const ProfileCardBioBox(
                content: 'Hey there, just a chill person here')
            : const SizedBox.shrink();
      case ScrollableListItemType.LOCATION:
        return item.location != null
            ? const ProfileCardBioBox(
                content: 'Hey there, just a chill person here')
            : const SizedBox.shrink();
    }
  }
}
