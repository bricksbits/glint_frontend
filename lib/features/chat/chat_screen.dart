import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/chat/story/model/recent_matches_model.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/features/chat/chat_screen_cubit.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/utils/date_and_time_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';
import 'package:intl/intl.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
                  context.pushNamed(GlintChatRoutes.stories.name);
                },
                child: SvgPicture.asset(
                  'lib/assets/icons/glint_heart.svg',
                ),
              ),
              const Gap(18.0),
              GestureDetector(
                onTap: () {
                  context.pushNamed(GlintChatRoutes.uploadStory.name);
                },
                child: SvgPicture.asset(
                  'lib/assets/icons/upload_story.svg',
                ),
              ),
            ],
          ),
          body: state.isLoading
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
                  : RefreshIndicator(
                      onRefresh: () async =>
                          state.channelListController?.refresh(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRecentMatchesSection(state.recentMatches ?? [],
                              (match) {
                            context.pushNamed(
                              GlintChatRoutes.chatWith.name,
                              extra: ChatWithNavArguments(
                                  channelId: match.chatChannelId,
                                  eventId: match.eventId,
                                  eventName: match.eventName,
                                  eventStartTime: match.eventStartTime),
                            );
                          },
                              noRecentMatches:
                                  state.recentMatches?.isEmpty ?? false),
                          const Gap(12.0),
                          Padding(
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
                          state.channelListController != null &&
                                  state.isChatReady
                              ? Expanded(
                                  child: StreamChannelListView(
                                    controller: state.channelListController!,
                                    itemBuilder: (context, channels, index,
                                        defaultTile) {
                                      final currentUserId =
                                          StreamChat.of(context)
                                              .currentUser!
                                              .id;
                                      final oppositeUser = channels[index]
                                          .state!
                                          .members
                                          .firstWhere(
                                            (member) =>
                                                member.user!.id !=
                                                currentUserId,
                                          );
                                      final oppositeUserName =
                                          oppositeUser.user!.name;
                                      final oppositeUserImage =
                                          oppositeUser.user?.image;

                                      final lastMessage =
                                          channels[index].state?.messages.last;
                                      final isLastMessageAMedia =
                                          lastMessage?.attachments.isNotEmpty ??
                                              false;
                                      final lastMessageDate =
                                          lastMessage?.createdAt ??
                                              DateTime.now();
                                      final unreadCount =
                                          channels[index].state?.unreadCount ??
                                              0;
                                      final myUserId = StreamChat.of(context)
                                              .currentUser
                                              ?.id ??
                                          0;

                                      // // Determine if the last message was sent by the opposite user and is unread
                                      final isUnreadFromOtherUser =
                                          lastMessage != null &&
                                              lastMessage.user?.id !=
                                                  myUserId &&
                                              unreadCount > 0;

                                      return ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 6.0,
                                          horizontal: 20.0,
                                        ),
                                        leading: Stack(
                                          clipBehavior: Clip.none,
                                          alignment: Alignment.center,
                                          children: [
                                            oppositeUserImage != null
                                                ? SizedBox(
                                                    height: 52.0,
                                                    width: 48.0,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(8.0),
                                                      ),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        placeholder:
                                                            'lib/assets/images/temp_place_holder.png',
                                                        // Local placeholder
                                                        image:
                                                            oppositeUserImage,
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: 220,
                                                        imageErrorBuilder:
                                                            (context, error,
                                                                stackTrace) {
                                                          return Image.asset(
                                                            'lib/assets/images/temp_place_holder.png',
                                                            fit: BoxFit.cover,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 52.0,
                                                    width: 48.0,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(8.0),
                                                      ),
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'lib/assets/images/temp_place_holder.png'),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        title: Text(
                                          oppositeUserName,
                                          style:
                                              AppTheme.simpleBodyText.copyWith(
                                            color: AppColours.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                          isLastMessageAMedia
                                              ? "Checkout this Image"
                                              : lastMessage?.text ??
                                                  "You got a new msg",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTheme.simpleText.copyWith(
                                            color: AppColours.darkGray,
                                          ),
                                        ),
                                        trailing: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Column(
                                            children: [
                                              if (isUnreadFromOtherUser)
                                                // your turn if message received
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 6,
                                                    vertical: 2.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                  child: Text(
                                                    'Your Turn',
                                                    style: AppTheme.simpleText
                                                        .copyWith(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColours.white,
                                                    ),
                                                  ),
                                                ),
                                              const Gap(8.0),
                                              Text(
                                                lastMessageDate
                                                    .toChatTimestamp(),
                                                style: AppTheme.smallBodyText
                                                    .copyWith(
                                                  color: AppColours.darkGray,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          context.pushNamed(
                                            GlintChatRoutes.chatWith.name,
                                            extra: ChatWithNavArguments(
                                              channelId:
                                                  channels[index].id ?? "0",
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    "Chat Server busy,",
                                    style: AppTheme.headingThree,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0).copyWith(bottom: 0),
        child: SizedBox(
          height: 128.0,
          child: ListView.builder(
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
                  margin: index == 0 ? const EdgeInsets.only(left: 16.0) : null,
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
                                      style: AppTheme.smallBodyText.copyWith(
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
    );
  }

  Widget _emptyStoriesRowSection() {
    return GradientCircularProgressIndicator(
      progress: 100,
      stroke: 3.6,
      gradient: AppColours.circularProgressGradient,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: 36,
          maxRadius: 36,
          backgroundImage: const NetworkImage(
            "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png",
          ),
        ),
      ),
    );
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
