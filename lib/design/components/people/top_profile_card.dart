import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/people/profile_action_button.dart';
import 'package:glint_frontend/design/components/people/profile_name_and_detail_column.dart';
import 'package:glint_frontend/design/components/people/share_profile_icon_button.dart';
import 'package:glint_frontend/features/people/model/scrollable_list_item_type.dart';

import 'last_profile_status_chips.dart';

//Todo: Remove the Error Placeholder with the design placeHolder
class TopProfileCard extends StatelessWidget {
  final VoidCallback shareProfile;
  final VoidCallback sendMessage;
  final VoidCallback sendSuperLike;
  final double screenHeight;
  final double screenWidth;
  final PeopleTopCardModel topCardModel;

  const TopProfileCard({
    super.key,
    required this.shareProfile,
    required this.sendMessage,
    required this.sendSuperLike,
    required this.screenHeight,
    required this.screenWidth,
    required this.topCardModel,
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
            topCardModel.imageUrl,
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
        Positioned.fill(
          child: Container(
            height: availableHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  AppColours.black.withValues(alpha: 0.5),
                  AppColours.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 16.0,
          left: 16.0,
          child: LastProfileStatusChips(text: topCardModel.profileTag),
        ),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: ShareProfileIconButton(onPressed: shareProfile),
        ),
        Positioned(
          bottom: 26.0,
          left: 20.0,
          right: 20.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileNameAndDetailColumn(
                name: topCardModel.name,
                distance: topCardModel.locationAway,
                views: topCardModel.views,
                age: topCardModel.age,
                isPremiumUser: false,
                designation: topCardModel.designation,
              ),
              Row(
                children: [
                  ProfileActionButton(
                    icon: 'lib/assets/icons/super_like.svg',
                    color: AppColours.white,
                    onPressed: sendSuperLike,
                  ),
                  const Gap(12.0),
                  ProfileActionButton(
                    icon: 'lib/assets/icons/direct_msg.svg',
                    color: AppColours.white,
                    onPressed: sendMessage,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
