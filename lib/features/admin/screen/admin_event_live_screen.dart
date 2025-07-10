import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class AdminEventLiveScreen extends StatelessWidget {
  const AdminEventLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: const GlintEventAuthAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // event manager greeting
              Text(
                'Your Event is now',
                style: AppTheme.headingThree.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                'LIVE',
                style: AppTheme.headingOne.copyWith(
                  fontStyle: FontStyle.normal,
                  fontSize: 40.0,
                ),
              ),
              const Gap(40.0),
              SizedBox(
                width: screenSize.width > 1050
                    ? screenSize.width / 2
                    : double.infinity,
                child: Column(
                  children: [
                    // const HotEvent(
                    //   eventId: 1,
                    // ),
                    const Gap(40.0),
                    SizedBox(
                      height: 52.0,
                      child: GlintIconElevatedButton(
                        customBorderRadius: 10.0,
                        backgroundColor: AppColours.primaryBlue,
                        onPressed: () {
                          //todo - handle track event admin click
                        },
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.track_changes,
                              color: AppColours.white,
                            ),
                            const Gap(12.0),
                            Text(
                              'Track Event',
                              style: AppTheme.simpleBodyText.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColours.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(16.0),
                    SizedBox(
                      height: 52.0,
                      child: GlintIconElevatedButton(
                        customBorderRadius: 10.0,
                        backgroundColor: AppColours.backgroundShade,
                        onPressed: () {
                          //todo - handle go back event admin click
                        },
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.arrow_back_ios,
                              color: AppColours.black,
                            ),
                            const Gap(12.0),
                            Text(
                              'Go to Home',
                              style: AppTheme.simpleBodyText.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColours.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
