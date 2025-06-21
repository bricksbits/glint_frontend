import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/glint_custom_app_bar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

import 'on_boarding_cubit.dart';

class DateOfBirthOnboardingScreen extends StatefulWidget {
  const DateOfBirthOnboardingScreen({super.key});

  @override
  State<DateOfBirthOnboardingScreen> createState() =>
      _DateOfBirthOnboardingScreenState();
}

class _DateOfBirthOnboardingScreenState
    extends State<DateOfBirthOnboardingScreen> {
  late DateTime _selectedDate;

  String userName = 'Abhishek';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year - 18, now.month, now.day);

    // show bottom date picker
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showBottomDatePicker();
    });
  }

  int calculateAge() {
    final now = DateTime.now();
    return (now.difference(_selectedDate).inDays ~/ 365);
  }

  void showAgeConfirmationSheet(BuildContext context) {
    context.showBottomSheet(
      isDismissible: false,
      enableDrag: false,
      (context) {
        return BlocBuilder<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0).copyWith(
                  bottom: 60.0,
                  top: 24.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: calculateAge().toString(),
                        style: AppTheme.headingOne.copyWith(
                          fontSize: 48.0,
                        ),
                        children: [
                          TextSpan(
                            text: ' years',
                            style: AppTheme.headingOne.copyWith(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(32.0),
                    Text(
                      'Hey $userName, your age is ${calculateAge()} years\nThis will be shown in your profile.',
                      style: AppTheme.simpleText,
                    ),
                    const Gap(32.0),
                    SizedBox(
                      width: double.infinity,
                      child: GlintElevatedButton(
                        label: 'Confirm Age',
                        foregroundColor: Colors.white,
                        backgroundColor: AppColours.primaryBlue,
                        onPressed: () {
                          if (calculateAge() >= 18) {
                            context
                                .read<OnBoardingCubit>()
                                .setAge(calculateAge().toString());
                          }
                          final currentAge = state.currentState?.dob;
                          if (currentAge != null && calculateAge() >= 18) {
                            final base = GlintMainRoutes.onBoarding.name;
                            final target = GlintBoardingRoutes.gender.name;
                            context.go("/$base/$target");
                          }
                        },
                      ),
                    ),
                    const Gap(12.0),
                    SizedBox(
                      width: double.infinity,
                      child: GlintElevatedButton(
                        label: 'Change DOB',
                        isCancel: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                          showBottomDatePicker();
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String get formattedDay => _selectedDate.day.toString().padLeft(2, '0');

  String get formattedMonth => _getMonthName(_selectedDate.month);

  String get formattedYear => _selectedDate.year.toString();

  String _getMonthName(int month) {
    return [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ][month - 1];
  }

  void showBottomDatePicker() {
    BottomPicker.date(
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: _selectedDate,
      pickerTextStyle: AppTheme.simpleText.copyWith(
        fontSize: 16.0,
      ),
      maxDateTime: DateTime(
        DateTime.now().year - 18,
        DateTime.now().month,
        DateTime.now().day,
      ),
      onSubmit: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
      dismissable: true,
      displayCloseIcon: false,
      bottomPickerTheme: BottomPickerTheme.plumPlate,
      pickerTitle: const SizedBox.shrink(),
      buttonWidth: 200.0,
      gradientColors: const [
        AppColours.primaryBlue,
        AppColours.purpleShade,
      ],
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingSafeAreaContainer(
        assetPath:
            'lib/assets/images/onboarding/stars_background_illustration.png',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Enter your\n',
                    style: AppTheme.headingOne.copyWith(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                    children: [
                      TextSpan(
                        text: 'Date of Birth',
                        style: AppTheme.headingOne.copyWith(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(40.0),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContainer(text: formattedDay),
                    const Gap(8.0),
                    _buildContainer(text: formattedMonth),
                    const Gap(8.0),
                    _buildContainer(text: formattedYear),
                  ],
                ),
                const Gap(28.0),
                const Text(
                  '*Age will not change afterwards.',
                  style: AppTheme.simpleText,
                ),
              ],
            ),
            const Spacer(flex: 10),
            SizedBox(
              width: double.infinity,
              child: GlintElevatedButton(
                label: 'Next',
                foregroundColor: Colors.white,
                backgroundColor: AppColours.primaryBlue,
                onPressed: () {
                  showAgeConfirmationSheet(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer({required String text}) {
    const defaultBorder = BorderSide(
      color: AppColours.primaryBlue,
      width: 1.0,
    );

    return GestureDetector(
      onTap: showBottomDatePicker,
      child: Container(
        height: 52.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          color: AppColours.white,
          borderRadius: BorderRadius.circular(38.0),
          border: Border(
            top: defaultBorder,
            left: defaultBorder,
            right: defaultBorder,
            bottom: defaultBorder.copyWith(width: 3.0),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTheme.simpleText.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
              color: AppColours.black,
            ),
          ),
        ),
      ),
    );
  }
}
