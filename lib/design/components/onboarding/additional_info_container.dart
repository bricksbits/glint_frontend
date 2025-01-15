import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class AdditionalInfoContainer extends StatefulWidget {
  const AdditionalInfoContainer({super.key});

  @override
  State<AdditionalInfoContainer> createState() =>
      _AdditionalInfoContainerState();
}

class _AdditionalInfoContainerState extends State<AdditionalInfoContainer> {
  // generic bottom sheet function
  void _showBottomSheet(BuildContext context) {
    context.showBottomSheet(
      isDismissible: false,
      (context) {
        return const SizedBox(
          width: double.infinity,
          height: 240.0,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColours.backgroundShade,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildAdditionalInfoItem(
            context,
            icon: Icons.work_outline,
            label: 'Occupation',
            onTap: () => _showBottomSheet(context),
          ),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.school_outlined,
            label: 'Education',
            onTap: () => _showBottomSheet(context),
          ),
          const Gap(8.0),
          const DottedLine(
            lineThickness: 0.5,
            dashColor: AppColours.primaryBlue,
          ),
          const Gap(8.0),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.straighten,
            label: 'Height',
            onTap: () => _showBottomSheet(context),
          ),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.fitness_center,
            label: 'Workout',
            onTap: () => _showBottomSheet(context),
          ),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.local_bar,
            label: 'Drinking',
            onTap: () => _showBottomSheet(context),
          ),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.smoking_rooms,
            label: 'Smoking',
            onTap: () => _showBottomSheet(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 12.0,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 0.0,
      ),
      leading: Icon(
        icon,
        size: 22.0,
      ),
      title: Text(
        label,
        style: AppTheme.lightText.copyWith(
          fontWeight: FontWeight.w300,
        ),
      ),
      trailing: Text(
        '+ Add'.toUpperCase(),
        style: AppTheme.simpleText.copyWith(
          fontWeight: FontWeight.w400,
          color: AppColours.primaryBlue,
        ),
      ),
    );
  }
}
