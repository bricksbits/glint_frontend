import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/chat/base/chat_channel_tile.dart';
import 'package:glint_frontend/features/chat/base/chat_screen_cubit.dart';
import 'package:glint_frontend/features/chat/story/model/recent_matches_model.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';
import 'package:intl/intl.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// When the app returns to the foreground, trigger a reconnect if the Stream
  /// WebSocket dropped while the app was backgrounded.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<ChatScreenCubit>().reconnectIfNeeded();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatScreenCubit, ChatScreenState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColours.white,
          appBar: AppBar(
            backgroundColor: AppColours.white,
            scrolledUnderElevation: 0,
            centerTitle: false,
            titleSpacing: 20,
            title: Text(
              "Chats",
              style: AppTheme.headingThree.copyWith(
                fontStyle: FontStyle.normal,
              ),
            ),
            actionsPadding: const EdgeInsets.only(right: 20.0),
            actions: [
              GestureDetector(
                onTap: () {
                  showCustomSnackbar(context,
                      message: "Story likes data will be available soon");
                  // context.pushNamed(GlintChatRoutes.stories.name);
                },
                child: SvgPicture.asset(
                  'lib/assets/icons/glint_heart.svg',
                ),
              ),
              const Gap(18.0),
              GestureDetector(
                onTap: () async {
                  GlintAnalyticService.onUploadStoriesEvent();
                  final bool? uploaded = await context
                      .pushNamed<bool>(GlintChatRoutes.uploadStory.name);
                  if (uploaded == true && mounted) {
                    _getStories();
                  }
                },
                child: SvgPicture.asset(
                  'lib/assets/icons/upload_story.svg',
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              GlintAnalyticService.onRefreshHitEvent();
              return context.read<ChatScreenCubit>().chatFacade();
            },
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.isChatReady == false ||
                        state.channelListController == null
                    ? const Center(
                        child: Text(
                          "Chat Servers are not available",
                          style: AppTheme.headingThree,
                        ),
                      )
                    : CustomScrollView(
                        // AlwaysScrollableScrollPhysics lets the RefreshIndicator
                        // trigger even when the header slivers alone fill the screen.
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          // ------------------------- Stories Section --------------------------- //
                          if (state.stories != null &&
                              state.stories!.isNotEmpty)
                            SliverToBoxAdapter(
                              child: _buildStoriesSection(state.stories!,
                                  (selectedIndex) {
                                context.pushNamed(
                                  GlintChatRoutes.stories.name,
                                  extra: (
                                    index: selectedIndex,
                                    stories: state.stories
                                  ),
                                );
                              }),
                            ),

                          // ------------------------- Recent Matches Section --------------------------- //
                          SliverToBoxAdapter(
                            child: _buildRecentMatchesSection(
                              state.recentMatches ?? [],
                              (match) {
                                context.pushNamed(
                                  GlintChatRoutes.chatWith.name,
                                  extra: ChatWithNavArguments(
                                    channelId: match.chatChannelId,
                                    eventId: match.eventId,
                                    eventName: match.eventName,
                                    eventStartTime: match.eventStartTime,
                                    matchId: match.matchId,
                                  ),
                                );
                              },
                              noRecentMatches:
                                  state.recentMatches?.isEmpty ?? false,
                            ),
                          ),

                          const SliverToBoxAdapter(child: Gap(12.0)),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Chats',
                                textAlign: TextAlign.start,
                                style: AppTheme.headingThree.copyWith(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),

                          // ------------------------- Chat Channels --------------------------- //
                          state.channelListController != null &&
                                  state.isChatReady
                              ? SliverFillRemaining(
                                  child: StreamChannelListView(
                                    controller: state.channelListController!,
                                    itemBuilder: (context, channels, index,
                                        defaultTile) {
                                      final currentUser =
                                          StreamChat.of(context).currentUser;
                                      return ChatChannelTile(
                                        key: ValueKey(channels[index].id),
                                        channel: channels[index],
                                        currentUserId: currentUser?.id,
                                        onTap: () => context.pushNamed(
                                          GlintChatRoutes.chatWith.name,
                                          extra: ChatWithNavArguments(
                                            channelId:
                                                channels[index].id ?? "0",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const SliverFillRemaining(
                                  child: Center(
                                    child: Text(
                                      "Chat servers down, please try after sometime.",
                                      style: AppTheme.headingThree,
                                    ),
                                  ),
                                ),
                        ],
                      ),
          ),
        );
      },
    );
  }

  Widget _buildRecentMatchesSection(
    List<RecentMatchesModel> recentMatches,
    void Function(RecentMatchesModel match) onRecentMatchItemClicked, {
    bool noRecentMatches = true,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColours.white,
        border: Border(
          bottom: BorderSide(
            color: AppColours.borderGray,
            width: 1.2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Matches",
                  style: AppTheme.headingThree.copyWith(
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0,
                  ),
                ),
                const Gap(2.0),
                const Text(
                  'Start conversation to find your spark',
                  style: AppTheme.simpleText,
                ),
                noRecentMatches ? const Gap(2.0) : const SizedBox.shrink(),
                noRecentMatches
                    ? const Text(
                        'Aiyoo! No Matches, buy premium and try your luck.',
                        style: AppTheme.simpleText,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          const Gap(20.0),
          !noRecentMatches
              ? SizedBox(
                  height: 120.0,
                  child: Row(
                    children: [
                      const Gap(12.0),
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: recentMatches.length,
                          itemBuilder: (context, index) {
                            var match = recentMatches[index];
                            return GestureDetector(
                              onTap: () {
                                onRecentMatchItemClicked(match);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(22.0),
                                          child: Image.network(
                                            match.matchUserImageUrl,
                                            width: 72.0,
                                            height: 72.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        if (match.matchedAtEvent)
                                          Positioned.fill(
                                            child: Container(
                                              height: 72.0,
                                              width: 72.0,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.transparent,
                                                    Colors.black
                                                        .withValues(alpha: 0.8),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(22.0),
                                              ),
                                            ),
                                          ),
                                        if (match.matchedAtEvent)
                                          const Positioned(
                                            bottom: 8,
                                            child: Icon(
                                              Icons.favorite,
                                              size: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const Gap(8.0),
                                    Text(
                                      match.matchUserName,
                                      style: AppTheme.simpleText.copyWith(
                                        color: AppColours.black,
                                      ),
                                    ),
                                    const Gap(12.0),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildStoriesSection(
    List<ViewStoryModel> viewStoryModel,
    void Function(int clickedIndex) storySelectedIndex,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColours.white,
        border: Border(
          bottom: BorderSide(
            color: AppColours.borderGray,
            width: 1.2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              "Stories",
              style: AppTheme.headingThree.copyWith(
                fontStyle: FontStyle.normal,
                fontSize: 18.0,
              ),
            ),
          ),
          const Gap(2.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0).copyWith(bottom: 0),
            child: SizedBox(
              height: 128.0,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: viewStoryModel.length,
                padding: const EdgeInsets.all(4),
                itemBuilder: (context, index) {
                  var story = viewStoryModel[index];
                  return GestureDetector(
                    onTap: () {
                      storySelectedIndex(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 16.0),
                      margin:
                          index == 0 ? const EdgeInsets.only(left: 16.0) : null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              GradientCircularProgressIndicator(
                                progress: 100,
                                stroke: 3.6,
                                gradient: AppColours.circularProgressGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CircleAvatar(
                                    radius: 36,
                                    backgroundImage:
                                        NetworkImage(story.userImageUrl),
                                  ),
                                ),
                              ),
                              if (int.parse(story.streakCount) > 0)
                                Positioned(
                                  bottom: -8.0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0, vertical: 3.6),
                                    decoration: BoxDecoration(
                                      color: AppColours.primaryBlue,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.local_fire_department,
                                          size: 14,
                                          color: AppColours.white,
                                        ),
                                        const Gap(2.0),
                                        Text(
                                          story.streakCount,
                                          style:
                                              AppTheme.smallBodyText.copyWith(
                                            color: AppColours.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const Gap(12.0),
                          Text(
                            story.username,
                            style: AppTheme.simpleText.copyWith(
                              color: AppColours.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getStories() {
    context.read<ChatScreenCubit>().refreshStories();
  }

  String formatDateTime(String isoDateString) {
    final dateTime = DateTime.parse(isoDateString).toLocal();
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      // today time
      return DateFormat('hh:mm a').format(dateTime);
    } else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      // Yesterday
      return 'Yesterday';
    } else {
      // older date
      return DateFormat('dd MMM').format(dateTime);
    }
  }
}
