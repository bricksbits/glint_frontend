import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class FeaturesLeftCountContainer extends StatelessWidget {
  const FeaturesLeftCountContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //superlikes
        Expanded(
          child: _buildPremiumFeaturesCountContainer(
            iconPath: 'lib/assets/icons/profile/superlike_icon.svg',
            count: 3,
            label: 'Superlikes',
          ),
        ),

        const Gap(12.0),

        //rewinds
        Expanded(
          child: _buildPremiumFeaturesCountContainer(
            iconPath: 'lib/assets/icons/profile/rewind_icon.svg',
            count: 8,
            label: 'Rewinds',
          ),
        ),

        const Gap(12.0),

        //superDM
        Expanded(
          child: _buildPremiumFeaturesCountContainer(
            iconPath: 'lib/assets/icons/profile/super_dm_icon.svg',
            count: 6,
            label: 'SuperDM',
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
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 18.0,
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
