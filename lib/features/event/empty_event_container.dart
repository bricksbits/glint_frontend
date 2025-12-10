import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/components/exports.dart';
import 'package:glint_frontend/utils/internet/handling_url_launches_util.dart';

class EmptyEventContainer extends StatelessWidget {
  const EmptyEventContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'lib/assets/icons/empty_state_bell_icon.svg',
            height: 60,
            width: 60,
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            "Events Coming Soon",
            style: AppTheme.headingOne,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "We’re bringing curated city events to Glint soon.\nYou’ll be able to discover, match, and plan\ntogether—right inside the app.",
            style: AppTheme.simpleText,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          GlintElevatedButton(
            label: "Follow Updates on our Inst",
            customTextStyle: AppTheme.simpleText.copyWith(
              color: Colors.white
            ),
            onPressed: () {
              HandlingUrlLaunchesUtil.openInstagramProfile(context, "glintapp");
            },
          ),
          const SizedBox(
            height: 16,
          ),
          GlintElevatedButton(
            label: "Write to us or for Business",
            customTextStyle: AppTheme.simpleText.copyWith(
                color: Colors.white
            ),
            onPressed: () {
              HandlingUrlLaunchesUtil.openUrl(
                  context, "http://glintapp.io/#subscription");
            },
          )
        ],
      ),
    );
  }
}
