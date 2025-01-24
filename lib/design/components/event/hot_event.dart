import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class HotEvent extends StatelessWidget {
  const HotEvent({super.key});

  @override
  Widget build(BuildContext context) {
    const eventName = 'The Local Food Fest';
    const eventDate = '20 Feb 2023';
    const eventLocation = 'Shriram business park';
    const eventOldPrice = '₹ 150';
    const eventNewPrice = '₹ 200';
    const eventDiscountDaysLeft = '30 days left';
    return Stack(
      children: [
        // Blurred background image
        Container(
          width: double.infinity,
          height: 215.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: const DecorationImage(
              image: NetworkImage(
                'https://media.istockphoto.com/id/1806011581/photo/overjoyed-happy-young-people-dancing-jumping-and-singing-during-concert-of-favorite-group.jpg?s=612x612&w=0&k=20&c=cMFdhX403-yKneupEN-VWSfFdy6UWf1H0zqo6QBChP4%3D',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withAlpha(
                  130,
                ),
              ),
            ),
          ),
        ),
        // Text content
        Positioned(
          top: 20,
          left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventName,
                style: AppTheme.headingThree.copyWith(
                  fontStyle: FontStyle.normal,
                  color: AppColours.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Gap(45.0),
            ],
          ),
        ),
      ],
    );
  }
}
