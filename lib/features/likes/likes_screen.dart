import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
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
                      'https://cdn.pixabay.com/photo/2023/05/12/10/47/ai-generated-7988262_640.jpg',
                  name: 'Ashima',
                  viewCount: 200,
                ),
                const GlintTopProfileContainer(
                  imageUrl:
                      'https://cdn.pixabay.com/photo/2023/05/12/10/47/ai-generated-7988262_640.jpg',
                  name: 'Swati',
                  viewCount: 340,
                ),
                const GlintTopProfileContainer(
                  imageUrl:
                      'https://cdn.pixabay.com/photo/2023/05/12/10/47/ai-generated-7988262_640.jpg',
                  name: 'Swati',
                  viewCount: 110,
                ),
                const GlintTopProfileContainer(
                  imageUrl:
                      'https://cdn.pixabay.com/photo/2023/05/12/10/47/ai-generated-7988262_640.jpg',
                  name: 'Swati',
                  viewCount: 420,
                ),
              ],
            ),
          ),

          const SliverGap(28.0),

          SliverToBoxAdapter(
            child: _buildProfileLikedYou(),
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
        ),
        image: DecorationImage(
          image: AssetImage(
            'lib/assets/images/blurred_noticed_profiles.png',
          ),
          fit: BoxFit.fitHeight,
          alignment: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 24.0,
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
            const Gap(24.0),
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

  Widget _buildProfileLikedYou() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'People liked your profile',
            style: AppTheme.simpleBodyText.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Act fast to get a match',
            style: AppTheme.simpleText.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return const GlintLikedYouProfileContainer(
                imageUrl:
                    'https://cdn-prod.medicalnewstoday.com/content/images/articles/326/326898/a-female-wondering-about-her-anatomy.jpg',
                name: 'Swati',
                age: 24,
              );
            },
          ),
        ],
      ),
    );
  }

  //empty state
  Widget _buildLikeScreenEmptyState() {
    return const GlintEmptyState(
      svgPath: 'lib/assets/icons/empty_state_like_icon.svg',
      title: 'No likes yet',
      subtitle: 'Start liking profiles to get discovered.',
    );
  }
}
