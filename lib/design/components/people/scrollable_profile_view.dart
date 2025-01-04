import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/people/last_profile_status_chips.dart';
import 'package:glint_frontend/design/components/people/profile_action_button.dart';
import 'package:glint_frontend/design/components/people/profile_card.dart';
import 'package:glint_frontend/design/components/people/profile_card_about_box.dart';
import 'package:glint_frontend/design/components/people/profile_card_bio_box.dart';
import 'package:glint_frontend/design/components/people/profile_designation_gradient_label.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_footer.dart';
import 'package:glint_frontend/design/components/people/share_profile_icon_button.dart';

//TODO(Nike): Use SliverDelegates to build the UI for performance improvements
//TODO(Nike): Use SliverRemaining to build the Footer performant
//TODO(Nike): Use proper Exports
class ScrollableProfileView extends StatefulWidget {
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

  @override
  State<ScrollableProfileView> createState() => _ScrollableProfileViewState();
}

class _ScrollableProfileViewState extends State<ScrollableProfileView> {
  final Queue<Widget>? additionalWidgetsQueue = Queue.from([
    const SliverToBoxAdapter(
      child: ProfileCardAboutBox(
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
    ),
    const SliverToBoxAdapter(
      child: ProfileCardBioBox(content: 'Hey there, just a chill person here'),
    ),
    const SliverToBoxAdapter(
      child: ProfileCardAboutBox(
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
    ),
    const SliverToBoxAdapter(
      child: ProfileCardBioBox(content: 'Hey there, just a chill person here'),
    ),
    const SliverFillRemaining(
      fillOverscroll: true,
      child: ScrollableProfileFooter(),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final List<String> images = widget.profileData["images"] ?? [];
    final String name = widget.profileData["name"] ?? "Name not available";
    final String bio = widget.profileData["bio"] ?? "";
    final String location =
        widget.profileData["location"] ?? "Location not specified";
    final List<String> interests = widget.profileData["interests"] ?? [];

    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: _dynamicProfileComponents(
        widget.profileData,
        additionalWidgetsQueue,
        screenHeight,
        screenWidth,
      ),
    );
  }
}

List<Widget> _dynamicProfileComponents(
  Map<String, dynamic> profileData,
  Queue<Widget>? additionalWidgets,
  double screenHeight,
  double screenWidth,
) {
  List<Widget> profileComponents = [];
  final List<String> images = profileData["images"] ?? [];

  // Various Checks are needed here
  for (int i = 0; i < images.length; i++) {
    if (i == 0 && images.isNotEmpty) {
      // Add the Sliver App Bar for First Image
      profileComponents.add(SliverAppBar(
        expandedHeight: screenHeight,
        flexibleSpace: FlexibleSpaceBar(
          background: ProfileCard(
            imageUrl: '',
            recentlyActive:
                const LastProfileStatusChips(text: 'Recently Active'),
            shareButton: ShareProfileIconButton(onPressed: () {}),
            gradientLabel:
                const ProfileDesignationGradientLabel(text: 'Doctor'),
            actionButtons: [
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              ),
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              ),
            ],
            errorImagePlaceHolderAsset:
                'lib/assets/images/place_holder_profile.png',
            isMainCard: true,
          ),
        ),
        pinned: false,
      ));

      if (additionalWidgets != null && additionalWidgets.isNotEmpty) {
        profileComponents.add(additionalWidgets.removeFirst());
      }
    } else {
      // Add the Other Profile Images if available or the components
      profileComponents.add(SliverToBoxAdapter(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: ProfileCard(
            imageUrl: '',
            recentlyActive:
                const LastProfileStatusChips(text: 'Recently Active'),
            shareButton: ShareProfileIconButton(onPressed: () {}),
            gradientLabel:
                const ProfileDesignationGradientLabel(text: 'Doctor'),
            actionButtons: [
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              ),
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              ),
            ],
            errorImagePlaceHolderAsset:
                'lib/assets/images/place_holder_profile.png',
            isMainCard: false,
          ),
        ),
      ));
      if (additionalWidgets != null && additionalWidgets.isNotEmpty) {
        profileComponents.add(additionalWidgets.removeFirst());
      }
    }
  }

  /**
   * This will handle the edge case when there is more components
   * rather than Images
   */
  if (additionalWidgets != null && additionalWidgets.isNotEmpty) {
    while (additionalWidgets.isNotEmpty) {
      profileComponents.add(additionalWidgets.removeFirst());
    }
  }
  return profileComponents;
}
