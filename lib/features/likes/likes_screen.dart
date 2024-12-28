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

          SliverToBoxAdapter(
            child: _buildTopProfiles(
              topProfiles: [
                const GlintTopProfileContainer(
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/70279771?v=4',
                  name: 'Ashima',
                  viewCount: 200,
                ),
                const GlintTopProfileContainer(
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/70279771?v=4',
                  name: 'Swati',
                  viewCount: 340,
                ),
                const GlintTopProfileContainer(
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/70279771?v=4',
                  name: 'Swati',
                  viewCount: 110,
                ),
                const GlintTopProfileContainer(
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/70279771?v=4',
                  name: 'Swati',
                  viewCount: 420,
                ),
              ],
            ),
          ),

          // empty state
          // SliverFillRemaining(
          //   hasScrollBody: false,
          //   child: _buildLikeScreenEmptyState(),
          // ),

          //bottom padding basically
          const SliverGap(16.0),
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
                debugPrint('clicked see profiles');
                //todo - add see profiles functionality
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopProfiles(
      {required List<GlintTopProfileContainer> topProfiles}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Text(
            'Top Profiles',
            style: AppTheme.simpleBodyText.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Gap(20.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const Gap(20.0), // for design replication purpose
              ...topProfiles,
            ],
          ),
        )
      ],
    );
  }

  //empty state
  Widget _buildLikeScreenEmptyState() {
    return const GlintEmptyState(
      svgPath: 'lib/assets/icons/like_icon.svg',
      title: 'No likes yet',
      subtitle: 'Start liking profiles to get discovered.',
    );
  }
}
