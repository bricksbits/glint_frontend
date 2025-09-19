import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/likes/likes_screen_cubit.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikesScreenCubit(),
      child: BlocBuilder<LikesScreenCubit, LikesScreenState>(
        builder: (context, state) {
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
                  child: _buildLikeScreenBanner(state.profileViewCount),
                )),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final topProfile = state.topProfiles.elementAt(index);
                      return GlintTopProfileContainer(
                        imageUrl: topProfile.pictureUrlList.first,
                        name: topProfile.username,
                        viewCount: topProfile.profileViews != null
                            ? int.parse(topProfile.profileViews!)
                            : 0,
                      );
                    },
                    childCount: state.topProfiles.length,
                  ),
                ),

                const SliverGap(28.0),

                SliverToBoxAdapter(
                  child: _buildProfileLikedYou(
                    state.superLikedAndLikedProfiles,
                  ),
                ),

                // empty state
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildLikeScreenEmptyState(
                      state.superLikeProfiles.isNotEmpty ||
                          state.likeProfiles.isNotEmpty),
                ),

                //bottom padding basically
                const SliverGap(16.0),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLikeScreenBanner(
    int profileViewCounts,
  ) {
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
            GlintGradientTextWidget(
              text: profileViewCounts.toString(),
              gradient: AppColours.textLinearGradient,
              style: const TextStyle(
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
            // GlintElevatedButton(
            //   label: 'See profiles',
            //   foregroundColor: Colors.white,
            //   backgroundColor: AppColours.primaryBlue,
            //   onPressed: () {
            //     debugPrint('clicked see profiles');
            //     //todo - add see profiles functionality
            //   },
            // )
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

  Widget _buildProfileLikedYou(
    List<PeopleCardModel> likedAndSuperLikedProfiles,
  ) {
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
            itemCount: likedAndSuperLikedProfiles.length,
            itemBuilder: (context, index) {
              final likedProfile = likedAndSuperLikedProfiles.elementAt(index);
              return GlintLikedYouProfileContainer(
                imageUrl: likedProfile.pictureUrlList.first,
                name: likedProfile.username,
                age: int.parse(likedProfile.age),
              );
            },
          ),
        ],
      ),
    );
  }

  //empty state
  Widget _buildLikeScreenEmptyState(bool isLikedProfileExists) {
    return isLikedProfileExists
        ? const GlintEmptyState(
            svgPath: 'lib/assets/icons/empty_state_like_icon.svg',
            title: 'No likes yet',
            subtitle: 'Start liking profiles to get discovered.',
          )
        : const SizedBox.shrink();
  }
}
