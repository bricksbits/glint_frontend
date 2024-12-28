import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class FilterPreferenceScreen extends StatelessWidget {
  const FilterPreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColours.scaffoldBackgroundColor,
      ), // for design replication purpose
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20.0,
            ),
            image: const DecorationImage(
              image: AssetImage(
                'lib/assets/images/filter_card_illustration.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                'It’s a little quiet here',
                style: AppTheme.headingTwo.copyWith(
                  fontStyle: FontStyle.normal,
                ),
              ),
              const Gap(10.0),
              const Text(
                'Try updating your preferences\n or boosting your profile!',
                textAlign: TextAlign.center,
                style: AppTheme.simpleText,
              ),
              const Gap(60.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 120.0,
      ),
    );
  }
}
