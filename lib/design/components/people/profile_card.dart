import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/people/profile_action_button.dart';
import 'package:glint_frontend/design/components/people/profile_designation_gradient_label.dart';
import 'package:glint_frontend/design/components/people/share_profile_icon_button.dart';

import 'last_profile_status_chips.dart';

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
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            height: screenHeight,
            width: screenWidth,
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) {
              return Image.asset(
                height: screenHeight,
                width: screenWidth,
                fit: BoxFit.cover,
                'lib/assets/images/temp_place_holder.png',
              );
            },
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileActionButton(
                icon: 'lib/assets/icons/direct_msg.svg',
                color: AppColours.white,
                onPressed: sendMessage,
              ),
              ProfileActionButton(
                icon: 'lib/assets/icons/super_like.svg',
                color: AppColours.white,
                onPressed: sendSuperLike,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
