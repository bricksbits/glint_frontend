import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glint_frontend/design/components/people/profile_card_about_box.dart';
import 'package:glint_frontend/design/components/people/profile_card_bio_box.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';

// Todo(Nike): Make the People Screen Const Again for better performance.
class PeopleScreen extends StatelessWidget {
  PeopleScreen({super.key});

  final List<Widget> list = [
    ScrollableProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      // child: CardSwiper(
      //   allowedSwipeDirection: const AllowedSwipeDirection.only(
      //       left: true, right: true, up: false, down: false),
      //   numberOfCardsDisplayed: 1,
      //   onUndo: (_, __, ___) {
      //     return false;
      //   },
      //   isLoop: true,
      //   cardsCount: list.length,
      //   cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
      //       list[index],
      // ),
      // child: ProfileCardAboutBox(
      //   title: 'About',
      //   tags: [
      //     {'icon': Icons.school, 'text': 'Graduate'},
      //     {'icon': Icons.person, 'text': 'She / Her'},
      //     {'icon': Icons.height, 'text': "5' 7"},
      //     {'icon': Icons.fitness_center, 'text': 'Gym freak'},
      //     {'icon': Icons.local_bar, 'text': 'Never'},
      //     {'icon': Icons.smoking_rooms, 'text': 'Never'},
      //   ],
      // ),
      child: ProfileCardBioBox(content: 'Hey\nIm\nJust a Chill Girl'),
    );
  }
}
