import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/people/profile_designation_gradient_label.dart';
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

  const TopProfileCard({
    super.key,
    required this.imageUrl,
    required this.recentActive,
    required this.shareProfile,
    required this.designation,
    required this.sendMessage,
    required this.sendSuperLike,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) {
              return Image.asset(
                fit: BoxFit.fill,
                'lib/assets/images/place_holder_profile.png',
              );
            },
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: LastProfileStatusChips(text: recentActive),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: ShareProfileIconButton(onPressed: shareProfile),
        ),
        Positioned(
          bottom: 80,
          left: 16,
          child: ProfileDesignationGradientLabel(text: designation),
        ),
        
        // Positioned(
        //   bottom: 16,
        //   left: 16,
        //   right: 16,
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       ProfileActionButton(
        //         icon: 'lib/assets/icons/direct_msg.svg',
        //         color: AppColours.white,
        //         onPressed: sendMessage,
        //       ),
        //       ProfileActionButton(
        //         icon: 'lib/assets/icons/super_like.svg',
        //         color: AppColours.white,
        //         onPressed: sendSuperLike,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
