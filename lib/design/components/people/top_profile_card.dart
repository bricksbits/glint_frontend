import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/people/profile_action_button.dart';
import 'package:glint_frontend/design/components/people/profile_name_and_detail_column.dart';
import 'package:glint_frontend/design/components/people/share_profile_icon_button.dart';

import 'last_profile_status_chips.dart';

//Todo: Remove the Error Placeholder with the design placeHolder
class TopProfileCard extends StatelessWidget {
  final String imageUrl;
  final String recentActive;
  final VoidCallback shareProfile;
  final String designation;
  final VoidCallback sendMessage;
  final VoidCallback sendSuperLike;
  final double screenHeight;
  final double screenWidth;

  const TopProfileCard({
    super.key,
    required this.imageUrl,
    required this.recentActive,
    required this.shareProfile,
    required this.designation,
    required this.sendMessage,
    required this.sendSuperLike,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final double safePadding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    const double appBarHeight = kToolbarHeight + 16;
    const double bottomNavHeight = 190.0;

    final double availableHeight =
        screenHeight - (safePadding + appBarHeight + bottomNavHeight);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
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
          top: 16.0,
          left: 16.0,
          child: LastProfileStatusChips(text: recentActive),
        ),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: ShareProfileIconButton(onPressed: shareProfile),
        ),
        Positioned(
          bottom: 20.0,
          left: 20.0,
          right: 20.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ProfileNameAndDetailColumn(
                name: 'Profile name',
                distance: '9',
                views: "62",
                age: "21",
                isPremiumUser: false,
                designation: 'Graphic Designer',
              ),
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
