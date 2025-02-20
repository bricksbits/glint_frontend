import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class TrackEventStats extends StatelessWidget {
  const TrackEventStats({
    super.key,
    required this.interestedUsers,
    required this.revenueGenerated,
  });

  final int interestedUsers;
  final int revenueGenerated;

  @override
  Widget build(BuildContext context) {
    final revenue = '₹ $revenueGenerated';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 26.0,
      ).copyWith(right: 12.0),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColours.borderGray,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          _buildLabelCount(
            label: 'Interested',
            count: interestedUsers.toString(),
            assetPath: 'lib/assets/icons/admin/users_two.svg',
          ),
          const Gap(20.0),
          const SizedBox(
            height: 80,
            child: VerticalDivider(
              thickness: 1.5,
              color: AppColours.borderGray,
            ),
          ),
          const Gap(32.0),
          _buildLabelCount(
            label: 'Revenue Generated',
            count: revenue,
            assetPath: 'lib/assets/icons/admin/money_stats.svg',
          ),
          const Spacer(
            flex: 4,
          )
        ],
      ),
    );
  }

  Widget _buildLabelCount({
    required String label,
    required String count,
    required String assetPath,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.0,
          height: 20.0,
          child: SvgPicture.asset(assetPath),
        ),
        const Gap(16.0),
        Text(
          count,
          style: AppTheme.heavyBodyText.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColours.primaryBlue,
            fontSize: 20.0,
          ),
        ),
        Text(
          label,
          style: AppTheme.simpleText,
        ),
      ],
    );
  }
}
