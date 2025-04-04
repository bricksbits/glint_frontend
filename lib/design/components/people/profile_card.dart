import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/people/profile_action_button.dart';

//Todo: Remove the Error Placeholder with the design placeHolder
class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final VoidCallback sendMessage;
  final VoidCallback sendSuperLike;
  final double screenHeight;
  final double screenWidth;

  const ProfileCard({
    super.key,
    required this.imageUrl,
    required this.sendMessage,
    required this.sendSuperLike,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final double availableHeight = MediaQuery.of(context).size.height -
        (kToolbarHeight + kBottomNavigationBarHeight + 240);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            height: availableHeight,
            width: screenWidth,
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) {
              return Image.asset(
                height: availableHeight,
                width: screenWidth,
                fit: BoxFit.cover,
                'lib/assets/images/temp_place_holder.png',
              );
            },
          ),
        ),
        Positioned(
          bottom: 24.0,
          left: 20.0,
          right: 20.0,
          child: Row(
            children: [
              const Spacer(),
              ProfileActionButton(
                icon: 'lib/assets/icons/super_like.svg',
                color: AppColours.white,
                onPressed: sendSuperLike,
                isSmall: true,
              ),
              const Gap(12.0),
              ProfileActionButton(
                icon: 'lib/assets/icons/direct_msg.svg',
                color: AppColours.white,
                onPressed: sendMessage,
                isSmall: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
