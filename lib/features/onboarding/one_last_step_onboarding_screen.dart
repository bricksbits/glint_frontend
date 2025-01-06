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

              // Bio field label
              const Text(
                'Enter your Bio',
                style: AppTheme.headingThree,
              ),
              const Gap(8.0),
              _buildBioField(),

              // Additional info
              const Gap(24.0),
              _buildAdditionalInfoContainer(),

              // Spacer
              const Spacer(),

              // Submit button
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
          setState(() {});
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
                '${_bioController.text.length} / 200',
                style: AppTheme.simpleText.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColours.white,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
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
