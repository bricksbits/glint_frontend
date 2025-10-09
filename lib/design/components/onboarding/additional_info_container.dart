import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/onboarding/common_bottom_sheet_chip_component.dart';
import 'package:glint_frontend/design/components/onboarding/common_bottom_sheet_text_component.dart';
import 'package:glint_frontend/design/components/onboarding/height_slider_component.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/profile/profile_properties_enum.dart';

class AdditionalInfoContainer extends StatefulWidget {
  const AdditionalInfoContainer({
    super.key,
    required this.occupation,
    required this.education,
    required this.height,
    required this.workoutHabits,
    required this.drinkingHabits,
    required this.smokingHabits,
    required this.occupationProvided,
    required this.educationSelected,
    required this.heightProvided,
    required this.workoutHabitSelected,
    required this.drinkingHabitSelected,
    required this.smokingHabitSelected,
  });

  final String? occupation;
  final String? education;
  final String? height;
  final String? workoutHabits;
  final String? drinkingHabits;
  final String? smokingHabits;

  final Function(String) occupationProvided;
  final Function(String) educationSelected;
  final Function(double) heightProvided;
  final Function(String) workoutHabitSelected;
  final Function(String) drinkingHabitSelected;
  final Function(String) smokingHabitSelected;

  @override
  State<AdditionalInfoContainer> createState() =>
      _AdditionalInfoContainerState();
}

class _AdditionalInfoContainerState extends State<AdditionalInfoContainer> {
  void _showHeightBottomSheet(BuildContext context) {
    context.showBottomSheet(
      isDismissible: true,
      (context) {
        return HeightInputComponent(
          heightSelected: (height) {
            widget.heightProvided(height);
          },
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
            onTap: () {
              context.showBottomSheet(
                isDismissible: true,
                (context) {
                  return CommonBottomSheetComponent(
                    title: 'Occupation',
                    icon: Icons.work_outline,
                    onValueAdded: (occ) {
                      widget.occupationProvided(occ);
                    },
                    lastValue: widget.occupation,
                  );
                },
              );
            },
            trailingText: widget.occupation,
          ),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.school_outlined,
            label: 'Education',
            onTap: () {
              context.showBottomSheet(
                isDismissible: true,
                (context) {
                  return CommonBottomSheetChipComponent(
                    title: 'Education',
                    icon: Icons.school_outlined,
                    selectedValue: getEnumFromString(
                        widget.education, Education.values, Education.graduate),
                    listValues: Education.values,
                    onSelection: (selectedItem) {
                      widget.educationSelected(selectedItem.name);
                    },
                  );
                },
              );
            },
            trailingText: widget.education,
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
            onTap: () => _showHeightBottomSheet(context),
            trailingText: widget.height,
          ),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.fitness_center,
            label: 'Workout',
            onTap: () {
              context.showBottomSheet(
                isDismissible: true,
                (context) {
                  return CommonBottomSheetChipComponent(
                    title: 'Workout',
                    icon: Icons.fitness_center,
                    selectedValue: getEnumFromString(widget.workoutHabits, WorkoutOptions.values, WorkoutOptions.sometimes),
                    listValues: WorkoutOptions.values,
                    onSelection: (selectedItem) {
                      widget.workoutHabitSelected(selectedItem.name);
                    },
                  );
                },
              );
            },
            trailingText: widget.workoutHabits,
          ),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.local_bar,
            label: 'Drinking',
            onTap: () {
              context.showBottomSheet(
                isDismissible: true,
                (context) {
                  return CommonBottomSheetChipComponent(
                    title: 'Drinking',
                    icon: Icons.local_bar,
                    selectedValue: getEnumFromString(widget.drinkingHabits, DrinkingHabit.values, DrinkingHabit.never),
                    listValues: DrinkingHabit.values,
                    onSelection: (selectedItem) {
                      widget.drinkingHabitSelected(selectedItem.name);
                    },
                  );
                },
              );
            },
            trailingText: widget.drinkingHabits,
          ),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.smoking_rooms,
            label: 'Smoking',
            onTap: () {
              context.showBottomSheet(
                isDismissible: true,
                (context) {
                  return CommonBottomSheetChipComponent(
                    title: 'Smoking',
                    icon: Icons.smoking_rooms,
                    selectedValue: getEnumFromString(widget.smokingHabits, SmokingHabit.values, SmokingHabit.nonSmoker),
                    listValues: SmokingHabit.values,
                    onSelection: (selectedItem) {
                      widget.smokingHabitSelected(selectedItem.name);
                    },
                  );
                },
              );
            },
            trailingText: widget.smokingHabits,
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
    required String? trailingText,
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
        trailingText ?? '+ Add'.toUpperCase(),
        style: AppTheme.simpleText.copyWith(
          fontWeight: FontWeight.w400,
          color: AppColours.primaryBlue,
        ),
      ),
    );
  }
}
