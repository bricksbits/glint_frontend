import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  static const list = [
    ScrollableProfileView(),
    ScrollableProfileView(),
    ScrollableProfileView(),
    ScrollableProfileView(),
    ScrollableProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardSwiper(
        isLoop: true,
        cardsCount: list.length,
        cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
            list[index],
      ),
      // body: ScrollableProfileView(),
    );
  }
}
