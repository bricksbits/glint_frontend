import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // app bar
          const SliverGlintCustomAppBar(
            title: 'Liked you',
          ),

          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 24.0,
            ),
            child: _buildLikeScreenBanner(),
          )),
          // empty state
          // SliverFillRemaining(
          //   hasScrollBody: false,
          //   child: Center(
          //     child:
          //         Text('Show case all the profiles which are liked by others'),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildLikeScreenBanner() {
    return Container(
      decoration: const BoxDecoration(
          color: AppColours.backgroundShade,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 28.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlintGradientTextWidget(
              text: "45",
              gradient: AppColours.textLinearGradient,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(4.0),
            Text(
              'people came\nacross your profile',
              style: AppTheme.simpleBodyText.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const Gap(32.0),
            GlintElevatedButton(
              label: 'See profiles',
              foregroundColor: Colors.white,
              backgroundColor: AppColours.primaryBlue,
              onPressed: () {
                print('hello');
              },
            )
          ],
        ),
      ),
    );
  }
}
