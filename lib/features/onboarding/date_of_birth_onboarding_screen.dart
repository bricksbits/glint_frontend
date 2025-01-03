import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class DateOfBirthOnboardingScreen extends StatefulWidget {
  const DateOfBirthOnboardingScreen({super.key});

  @override
  State<DateOfBirthOnboardingScreen> createState() =>
      _DateOfBirthOnboardingScreenState();
}

class _DateOfBirthOnboardingScreenState
    extends State<DateOfBirthOnboardingScreen> {
  late DateTime _selectedDate;

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
      maxDateTime: DateTime(DateTime.now().year),
      onSubmit: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
      dismissable: true,
      displayCloseIcon: false,
      bottomPickerTheme: BottomPickerTheme.plumPlate,
      pickerTitle: const SizedBox.shrink(),
      buttonWidth: MediaQuery.of(context).size.width * 0.6,
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
                  // TODO: Handle navigation or next step
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
