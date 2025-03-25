import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';

// Todo(Nike): Make the People Screen Const Again for better performance.
class PeopleScreen extends StatelessWidget {
  PeopleScreen({super.key});

  final List<Widget> list = [
    ScrollableProfileView(),
    ScrollableProfileView(),
    ScrollableProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      allowedSwipeDirection: const AllowedSwipeDirection.only(
          left: true, right: true, up: false, down: false),
      numberOfCardsDisplayed: 1,
      onUndo: (_, __, ___) {
        return false;
      },
      isLoop: false,
      cardsCount: list.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
          list[index],
    );
  }
}
