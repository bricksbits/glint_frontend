import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileVennDiagram extends StatelessWidget {
  final String profilePhoto1Url;
  final String profilePhoto2Url;
  final String logoUrl;

  const ProfileVennDiagram({
    super.key,
    required this.profilePhoto1Url,
    required this.profilePhoto2Url,
    required this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left Profile Image
        ClipOval(
          child: Image.network(
            profilePhoto1Url,
            // Replace with the left profile image URL
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        // Icon in the middle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                logoUrl, // Replace with your heart SVG path
                width: 24,
                height: 24,
                color: Colors.purple,
              ),
            ),
          ),
        ),
        // Right Profile Image
        ClipOval(
          child: Image.network(
            profilePhoto2Url,
            // Replace with the right profile image URL
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
