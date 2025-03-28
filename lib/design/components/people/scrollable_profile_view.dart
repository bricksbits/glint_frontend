import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/people/exports.dart';
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
      'https://content.api.news/v3/images/bin/9816751587a5e583738e01fc87fb0f52?width=1024',
      'https://content.api.news/v3/images/bin/9816751587a5e583738e01fc87fb0f52?width=1024',
      'https://content.api.news/v3/images/bin/9816751587a5e583738e01fc87fb0f52?width=1024',
      'https://content.api.news/v3/images/bin/9816751587a5e583738e01fc87fb0f52?width=1024',
      'https://content.api.news/v3/images/bin/9816751587a5e583738e01fc87fb0f52?width=1024',
      'https://content.api.news/v3/images/bin/9816751587a5e583738e01fc87fb0f52?width=1024',
      'https://content.api.news/v3/images/bin/9816751587a5e583738e01fc87fb0f52?width=1024',
      'https://content.api.news/v3/images/bin/9816751587a5e583738e01fc87fb0f52?width=1024',
      'https://content.api.news/v3/images/bin/9816751587a5e583738e01fc87fb0f52?width=1024',
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
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
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
          ),

          const SliverGap(8.0),

          // List of Items Sliver
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    const Gap(32.0),
                    buildListItem(peopleUiModel.convert().listModel[index],
                        screenWidth, screenHeight)
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
            ? const ProfileCardAboutBox(
                title: 'About',
                tags: [
                  {
                    'icon': Icons.school,
                    'text': 'Graduate',
                  },
                  {
                    'icon': Icons.wc,
                    'text': 'She/Her',
                  },
                  {
                    'icon': Icons.straighten,
                    'text': '5\'10',
                  },
                  {
                    'icon': Icons.fitness_center,
                    'text': 'Gym freak',
                  },
                  {
                    'icon': Icons.local_bar,
                    'text': 'Never',
                  },
                  {
                    'icon': Icons.smoking_rooms,
                    'text': 'Never',
                  }
                ],
                name: 'Abhishek',
              )
            : const SizedBox.shrink();
      case ScrollableListItemType.BIO:
        return item.bio != null
            ? const ProfileCardBioBox(
                content: 'Hey there, just a chill person here')
            : const SizedBox.shrink();
      case ScrollableListItemType.LOOKING_FOR:
        return item.lookingFor != null
            ? const ProfileCardLookingForBox(lookingFor: 'Something Casual')
            : const SizedBox.shrink();
      case ScrollableListItemType.INTEREST:
        return item.interests != null
            ? const ProfileInterestVibeBox(
                interests: [
                  {
                    'label': 'Photography',
                    'icon': '📸',
                  },
                  {
                    'label': 'Stand-Up Comedy',
                    'icon': '🎙',
                  },
                  {
                    'label': 'Bollywood',
                    'icon': '💃🏻',
                  },
                  {
                    'label': 'Music',
                    'icon': '🎧',
                  },
                  {
                    'label': 'Yoga',
                    'icon': '🧘',
                  },
                  {
                    'label': 'Festivals',
                    'icon': '🎊',
                  },
                  {
                    'label': 'Travelling',
                    'icon': '✈️',
                  },
                ],
              )
            : const SizedBox.shrink();
      case ScrollableListItemType.LOCATION:
        return item.location != null
            ? const ProfileLocationBox(
                location: 'Karnal, Haryana',
                distance: '9',
              )
            : const SizedBox.shrink();
    }
  }
}
