import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class OneLastStepOnboardingScreen extends StatefulWidget {
  const OneLastStepOnboardingScreen({super.key});

  @override
  State<OneLastStepOnboardingScreen> createState() =>
      _OneLastStepOnboardingScreenState();
}

class _OneLastStepOnboardingScreenState
    extends State<OneLastStepOnboardingScreen> {
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  // occupation
  void showOccupationBottomSheet(BuildContext context) {
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

  // education
  void showEducationBottomSheet(BuildContext context) {
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

  // height
  void showHeightBottomSheet(BuildContext context) {
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

  // workout
  void showWorkoutBottomSheet(BuildContext context) {
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

  // drinking
  void showDrinkingBottomSheet(BuildContext context) {
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

  // smoking
  void showSmokingBottomSheet(BuildContext context) {
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
    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
            bottom: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'One Last ',
                    style: AppTheme.headingOne.copyWith(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                    children: [
                      TextSpan(
                        text: 'Step',
                        style: AppTheme.headingOne.copyWith(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(44.0),

              //bio field label
              const Text(
                'Enter your Bio',
                style: AppTheme.headingThree,
              ),
              const Gap(8.0),
              _buildBioField(),

              //additional info
              const Gap(24.0),
              _buildAdditionalInfoContainer(),

              //spacer
              const Spacer(),

              // submit button
              SizedBox(
                width: double.infinity,
                child: GlintElevatedButton(
                  label: 'Next',
                  foregroundColor: Colors.white,
                  backgroundColor: AppColours.primaryBlue,
                  onPressed: () {
                    // Handle button press
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBioField() {
    const defaultBorder = BorderSide(
      color: AppColours.primaryBlue,
      width: 1.0,
    );
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border(
          top: defaultBorder,
          left: defaultBorder,
          right: defaultBorder,
          bottom: defaultBorder.copyWith(width: 3.0),
        ),
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        autocorrect: true,
        maxLength: 200,
        controller: _bioController,
        cursorColor: AppColours.primaryBlue,
        style: AppTheme.simpleBodyText.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: AppColours.black,
        ),
        onChanged: (value) {
          if (value.trim().isEmpty) {
            setState(() {
              _bioController.text = '';
            });
          }
          if (value.trim().isNotEmpty) {
            setState(() {
              _bioController.text = value;
            });
          }
        },
        decoration: InputDecoration(
          counter: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: AppColours.primaryBlue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '${_bioController.text.length}/200',
                style: AppTheme.simpleText.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColours.white,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          // no counter
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColours.backgroundShade,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // important info
          ListTile(
            dense: true,
            horizontalTitleGap: 12.0,
            onTap: () => showOccupationBottomSheet(context),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 0.0,
            ),
            leading: const Icon(
              Icons.work_outline,
              size: 20.0,
            ),
            title: Text(
              'Occupation',
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
          ),
          ListTile(
            dense: true,
            horizontalTitleGap: 12.0,
            onTap: () => showEducationBottomSheet(context),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 0.0,
            ),
            leading: const Icon(
              Icons.school_outlined,
              size: 22.0,
            ),
            title: Text(
              'Education',
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
          ),

          const Gap(8.0),
          // divider
          const DottedLine(
            lineThickness: 0.5,
            dashColor: AppColours.primaryBlue,
          ),
          const Gap(8.0),

          // other info
          ListTile(
            dense: true,
            horizontalTitleGap: 12.0,
            onTap: () => showHeightBottomSheet(context),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 0.0,
            ),
            leading: const Icon(
              Icons.straighten,
              size: 20.0,
            ),
            title: Text(
              'Height',
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
          ),
          ListTile(
            dense: true,
            horizontalTitleGap: 12.0,
            onTap: () => showWorkoutBottomSheet(context),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 0.0,
            ),
            leading: const Icon(
              Icons.fitness_center,
              size: 22.0,
            ),
            title: Text(
              'Workout',
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
          ),
          ListTile(
            dense: true,
            horizontalTitleGap: 12.0,
            onTap: () => showDrinkingBottomSheet(context),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 0.0,
            ),
            leading: const Icon(
              Icons.local_bar,
              size: 22.0,
            ),
            title: Text(
              'Drinking',
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
          ),
          ListTile(
            dense: true,
            horizontalTitleGap: 12.0,
            onTap: () => showSmokingBottomSheet(context),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 0.0,
            ),
            leading: const Icon(
              Icons.smoking_rooms,
              size: 22.0,
            ),
            title: Text(
              'Smoking',
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
          ),
        ],
      ),
    );
  }
}
