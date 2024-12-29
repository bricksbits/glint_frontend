import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintAgeDistanceCard extends StatefulWidget {
  const GlintAgeDistanceCard({
    super.key,
  });

  @override
  State<GlintAgeDistanceCard> createState() => _GlintAgeDistanceCardState();
}

class _GlintAgeDistanceCardState extends State<GlintAgeDistanceCard> {
  // age range variables
  double fromAge = 18;
  double toAge = 60;

  //distance variable
  double distance = 10;

  @override
  Widget build(BuildContext context) {
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
