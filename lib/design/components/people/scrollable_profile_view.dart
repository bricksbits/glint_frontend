import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/people/last_profile_status_chips.dart';
import 'package:glint_frontend/design/components/people/profile_action_button.dart';
import 'package:glint_frontend/design/components/people/profile_card.dart';
import 'package:glint_frontend/design/components/people/profile_designation_gradient_label.dart';
import 'package:glint_frontend/design/components/people/share_profile_icon_button.dart';

class ScrollableProfileView extends StatelessWidget {
  const ScrollableProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileCard(
            imageUrl: '',
            recentlyActive:
                const LastProfileStatusChips(text: 'Recently Active'),
            shareButton: ShareProfileIconButton(onPressed: () {}),
            gradientLabel:
                const ProfileDesignationGradientLabel(text: 'Doctor'),
            actionButtons: [
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              ),
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              )
            ],
            errorImagePlaceHolderAsset:
                'lib/assets/images/place_holder_profile.png',
          ),
          ProfileCard(
            imageUrl: '',
            recentlyActive:
                const LastProfileStatusChips(text: 'Recently Active'),
            shareButton: ShareProfileIconButton(onPressed: () {}),
            gradientLabel:
                const ProfileDesignationGradientLabel(text: 'Doctor'),
            actionButtons: [
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              ),
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              )
            ],
            errorImagePlaceHolderAsset:
                'lib/assets/images/place_holder_profile.png',
          ),
          ProfileCard(
            imageUrl: '',
            recentlyActive:
                const LastProfileStatusChips(text: 'Recently Active'),
            shareButton: ShareProfileIconButton(onPressed: () {}),
            gradientLabel:
                const ProfileDesignationGradientLabel(text: 'Doctor'),
            actionButtons: [
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              ),
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              )
            ],
            errorImagePlaceHolderAsset:
                'lib/assets/images/place_holder_profile.png',
          ),
          ProfileCard(
            imageUrl: '',
            recentlyActive:
                const LastProfileStatusChips(text: 'Recently Active'),
            shareButton: ShareProfileIconButton(onPressed: () {}),
            gradientLabel:
                const ProfileDesignationGradientLabel(text: 'Doctor'),
            actionButtons: [
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              ),
              ProfileActionButton(
                icon: Icons.mail,
                color: AppColours.white,
                onPressed: () {},
              )
            ],
            errorImagePlaceHolderAsset:
                'lib/assets/images/place_holder_profile.png',
          ),
        ],
      ),
    );
  }
}
