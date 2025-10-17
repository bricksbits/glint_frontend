import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class FeaturesLeftCountContainer extends StatelessWidget {
  const FeaturesLeftCountContainer(
      {super.key,
      required this.superLikeCounts,
      required this.rewindCounts,
      required this.superDmCounts});

  final int superLikeCounts;
  final int rewindCounts;
  final int superDmCounts;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    return Row(
      children: [
        //superlikes
        Expanded(
          child: _buildPremiumFeaturesCountContainer(
            iconPath: 'lib/assets/icons/super_like.svg',
            count: superLikeCounts,
            label: 'Superlikes',
            isSmallScreen: isSmallScreen,
          ),
        ),

        const Gap(12.0),

        //rewinds
        Expanded(
          child: _buildPremiumFeaturesCountContainer(
            iconPath: 'lib/assets/icons/profile/rewind_icon.svg',
            count: rewindCounts,
            label: 'Rewinds',
            isSmallScreen: isSmallScreen,
          ),
        ),

        const Gap(12.0),

        //superDM
        Expanded(
          child: _buildPremiumFeaturesCountContainer(
            iconPath: 'lib/assets/icons/direct_msg.svg',
            count: superDmCounts,
            label: 'SuperDM',
            isSmallScreen: isSmallScreen,
          ),
        )
      ],
    );
  }
}

Widget _buildPremiumFeaturesCountContainer({
  required String iconPath,
  required int count,
  required String label,
  required bool isSmallScreen,
}) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: isSmallScreen ? 14.0 : 18.0,
      vertical: 18.0,
    ),
    decoration: BoxDecoration(
      color: AppColours.backgroundShade,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const Gap(6.0),
            Text(
              count.toString(),
              style: const TextStyle(
                fontFamily: 'AlbertSans',
                fontSize: 22.0,
                fontWeight: FontWeight.w800,
                color: AppColours.black,
              ),
            )
          ],
        ),
        const Gap(6.0),
        RichText(
          text: TextSpan(
            text: label,
            style: AppTheme.smallBodyText.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: isSmallScreen ? 10.0 : null,
            ),
            children: const [
              TextSpan(
                text: ' left',
                style: AppTheme.smallBodyText,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
