import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/people/profile_card.dart';
import 'package:glint_frontend/design/components/people/top_profile_card.dart';
import 'package:glint_frontend/design/components/people/profile_card_about_box.dart';
import 'package:glint_frontend/design/components/people/profile_card_bio_box.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_footer.dart';

//TODO(Nike): Use proper Exports
class ScrollableProfileView extends StatelessWidget {
  final Map<String, dynamic> profileData;

  ScrollableProfileView({
    super.key,
    // required this.profileData,
  }) : profileData = {
          "name": "Shalini, 21",
          "bio": "Just a chill girl!",
          "location": "Delhi, Chandigarh",
          "interests": [
            "Photography",
            "Music and Concerts",
            "Business",
            "Yoga",
            "Traveling"
          ],
          "images": [
            "https://example.com/image1.jpg",
            "https://example.com/image2.jpg",
          ]
        };

  final List<Widget> additionalWidgetsList = [
    const ProfileCardAboutBox(
      title: 'About',
      tags: [
        {'icon': Icons.school, 'text': 'Graduate'},
        {'icon': Icons.person, 'text': 'She / Her'},
        {'icon': Icons.height, 'text': "5' 7"},
        {'icon': Icons.fitness_center, 'text': 'Gym freak'},
        {'icon': Icons.local_bar, 'text': 'Never'},
        {'icon': Icons.smoking_rooms, 'text': 'Never'},
      ],
    ),
    const ProfileCardBioBox(content: 'Hey there, just a chill person here'),
    const ProfileCardBioBox(content: 'Hey there, just a chill person here'),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final List<String> images = profileData["images"] ?? [];
    final String name = profileData["name"] ?? "Name not available";
    final String bio = profileData["bio"] ?? "";
    final String location = profileData["location"] ?? "Location not specified";
    final List<String> interests = profileData["interests"] ?? [];

    final int totalItems =
        (images.length - 1) + additionalWidgetsList.length + 2;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: totalItems,
      itemBuilder: (context, index) {
        if (index == 0) {
          // 🔥 First Image with Detailed Info
          return TopProfileCard(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            imageUrl: '',
            recentActive: "New",
            shareProfile: () {},
            designation: "Fashion Designer",
            sendMessage: () {},
            sendSuperLike: () {},
          );
        } else if (index == totalItems - 1) {
          // 🔥 Footer at the End
          return const ScrollableProfileFooter();
        } else {
          int adjustedIndex = index - 1; // Adjust for first image
          // 🔄 Alternate between Images and Sections
          if (adjustedIndex.isOdd) {
            int sectionIndex = adjustedIndex ~/ 2;
            if (sectionIndex < additionalWidgetsList.length) {
              return additionalWidgetsList[sectionIndex];
            }
          } else {
            int imageIndex = (adjustedIndex ~/ 2) + 1;
            if (imageIndex < images.length) {
              return ProfileCard(
                imageUrl: '',
                sendMessage: () {},
                sendSuperLike: () {},
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              );
            }
          }
          return const SizedBox.shrink();
        }
      },
    );
  }
}
