import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class FilterPreferenceScreen extends StatefulWidget {
  const FilterPreferenceScreen({super.key});

  @override
  State<FilterPreferenceScreen> createState() => _FilterPreferenceScreenState();
}

class _FilterPreferenceScreenState extends State<FilterPreferenceScreen> {
  // age range variables
  double fromAge = 18;
  double toAge = 60;

  double distance = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: AppBar(
        backgroundColor: AppColours.white, // Matches the screen background
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0)
              .copyWith(bottom: 24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            // Rounded corners for the card
            image: const DecorationImage(
              image:
                  AssetImage('lib/assets/images/filter_card_illustration.png'),
              fit: BoxFit.fill, // Fills the entire container
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'lib/assets/icons/filter_card_main_icon.svg',
                alignment: Alignment.center,
                width: 52.0,
                height: 52.0,
              ),
              const Gap(10.0),

              Text(
                'It’s a little quiet here', // Main title
                style:
                    AppTheme.headingTwo.copyWith(fontStyle: FontStyle.normal),
              ),
              const Gap(10.0),

              const Text(
                'Try updating your preferences\n or boosting your profile!',
                textAlign: TextAlign.center,
                style: AppTheme.simpleText,
              ),
              const Gap(60.0),
              _buildFilterPreferenceCards(), // the filter card UI
              const Gap(32.0),
              SizedBox(
                width: double.infinity,
                child: GlintElevatedButton(
                  label: 'Apply Changes',
                  isPrimary: true,
                  onPressed: () {
                    //todo - Apply the selected filter changes
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SizedBox(height: 120.0),
    );
  }

  Widget _buildFilterPreferenceCards() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          // select age range
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Age',
                      style: AppTheme.simpleBodyText
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Between ${fromAge.toInt()} - ${toAge.toInt()}',
                      style: AppTheme.simpleText,
                    ),
                  ],
                ),
                const Gap(16.0),
                // age range slider
                FlutterSlider(
                  // initial val
                  values: [fromAge, toAge],
                  rangeSlider: true,
                  // min age limit
                  min: 18,
                  // max age limit
                  max: 60,
                  minimumDistance: 3,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      fromAge = lowerValue;
                      toAge = upperValue;
                    });
                  },
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBar: BoxDecoration(
                      color: AppColours.primaryBlue60,
                    ),
                    inactiveTrackBar: BoxDecoration(
                      color: AppColours.gray60,
                    ),
                  ),
                  tooltip: FlutterSliderTooltip(disabled: true),
                  handlerHeight: 16.0,
                  handlerWidth: 16.0,
                  handler: FlutterSliderHandler(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColours.primaryBlue,
                    ),
                    child: const SizedBox.shrink(),
                  ),
                  rightHandler: FlutterSliderHandler(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColours.primaryBlue,
                    ),
                    child: const SizedBox.shrink(),
                  ),
                )
              ],
            ),
          ),

          const Gap(20.0),

          // horizontal divider
          const Divider(
            thickness: 0.5,
            color: AppColours.gray,
          ),

          const Gap(20.0),

          // distance divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Adjust Distance',
                      style: AppTheme.simpleBodyText
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${distance.toInt()} Kms',
                      style: AppTheme.simpleText,
                    ),
                  ],
                ),
                const Gap(16.0),
                // age range slider
                FlutterSlider(
                  // initial val
                  values: [distance],
                  min: 5,
                  max: 60,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      distance = lowerValue;
                    });
                  },
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBar: BoxDecoration(
                      color: AppColours.primaryBlue60,
                    ),
                    inactiveTrackBar: BoxDecoration(
                      color: AppColours.gray60,
                    ),
                  ),
                  tooltip: FlutterSliderTooltip(disabled: true),
                  handlerHeight: 16.0,
                  handlerWidth: 16.0,
                  handler: FlutterSliderHandler(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColours.primaryBlue,
                    ),
                    child: const SizedBox.shrink(),
                  ),
                  rightHandler: FlutterSliderHandler(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColours.primaryBlue,
                    ),
                    child: const SizedBox.shrink(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
