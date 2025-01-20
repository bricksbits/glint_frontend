import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class MainExploreScreen extends StatelessWidget {
  const MainExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          //top padding
          Gap(30.0),
          ExploreCard(
            imagePath: 'lib/assets/images/event/pet_card_illustration.png',
            title: 'Pets Companion',
            subtitle: 'Find someone who shares\nyour love for furry friends',
          ),
          Gap(16.0),
          ExploreCard(
            imagePath: 'lib/assets/images/event/coffee_card_illustration.png',
            title: 'Coffee Date',
            subtitle: 'Brew the perfect\nconnection over coffee',
          ),
          Gap(16.0),
          ExploreCard(
            imagePath: 'lib/assets/images/event/movie_card_illustration.png',
            title: 'Movie Date',
            subtitle: 'Lights, camera,\nconnection!',
          ),
          Gap(16.0),
          ExploreCard(
            imagePath: 'lib/assets/images/event/travel_card_illustration.png',
            title: 'Travel Buddies',
            subtitle: 'Find your travel buddy\nfor endless adventures',
          ),
        ],
      ),
    );
  }
}
