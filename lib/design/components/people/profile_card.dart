import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final Widget recentlyActive;
  final Widget shareButton;
  final Widget gradientLabel;
  final List<Widget> actionButtons;
  final String errorImagePlaceHolderAsset;

  const ProfileCard({
    super.key,
    required this.imageUrl,
    required this.recentlyActive,
    required this.shareButton,
    required this.gradientLabel,
    required this.actionButtons,
    required this.errorImagePlaceHolderAsset,
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
            width: 350,
            height: 350,
            errorBuilder: (context, error, stack) {
              return Image.asset(
                width: 350,
                height: 350,
                fit: BoxFit.fill,
                errorImagePlaceHolderAsset,
              );
            },
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: recentlyActive,
        ),
        Positioned(
          top: 16,
          right: 16,
          child: shareButton,
        ),
        Positioned(
          bottom: 80,
          left: 16,
          child: gradientLabel,
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actionButtons,
          ),
        ),
      ],
    );
  }
}
