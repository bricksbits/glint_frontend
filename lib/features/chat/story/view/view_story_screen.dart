import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/components/chat/story_comment_like.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/features/chat/story/view/view_story_cubit.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ViewStoryScreen extends StatefulWidget {
  const ViewStoryScreen(
      {super.key, required this.passedIndex, required this.passedStories});

  final int? passedIndex;
  final List<ViewStoryModel>? passedStories;

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  final storyCommentTextController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  String? currentChannel;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);

    _commentFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _commentFocusNode.removeListener(_handleFocusChange);
    _commentFocusNode.dispose();
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stories = widget.passedStories;
    return BlocProvider(
      create: (context) => ViewStoryCubit(),
      child: BlocBuilder<ViewStoryCubit, ViewStoryState>(
        builder: (context, state) {
          return Scaffold(
            body: stories?.isNotEmpty == true
                ? StoryPageView(
                    initialPage: widget.passedIndex ?? 0,
                    showShadow: true,
                    itemBuilder: (context, pageIndex, storyIndex) {
                      final currentVisibleUser = stories?[pageIndex];
                      final currentVisibleStory =
                          currentVisibleUser?.storiesUrl[storyIndex];
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: StoryImage(
                              key: ValueKey(currentVisibleStory),
                              imageProvider: NetworkImage(
                                currentVisibleStory ?? "",
                              ),
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Image.asset(
                                  fit: BoxFit.cover,
                                  'lib/assets/images/temp_place_holder.png',
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 44, left: 8),
                            child: Row(
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          currentVisibleUser?.userImageUrl ??
                                              ""),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColours.black,
                                    borderRadius:
                                        BorderRadiusGeometry.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      currentVisibleUser?.username ?? "",
                                      style: AppTheme.simpleBodyText.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColours.white,
                                    borderRadius:
                                        BorderRadiusGeometry.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye,
                                        ),
                                        const Gap(4),
                                        Text(
                                          currentVisibleUser?.storyViewCount ??
                                              "0",
                                          style: AppTheme.smallBodyText,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Gap(4),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    gestureItemBuilder: (context, pageIndex, storyIndex) {
                      final currentActiveUser = stories?[pageIndex];
                      currentChannel = currentActiveUser?.streamChannelId;
                      return LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Stack(
                            children: [
                              currentActiveUser?.isOwnStory == false
                                  ? Positioned(
                                      bottom: 16,
                                      left: 2,
                                      right: 2,
                                      child: StoryCommentTextInput(
                                        focusNode: _commentFocusNode,
                                        storyCommentController:
                                            storyCommentTextController,
                                        onCommentSend: () {
                                          if (currentChannel != null) {
                                            context
                                                .read<ViewStoryCubit>()
                                                .replyToStory(
                                                  currentChannel!,
                                                  storyCommentTextController
                                                      .text,
                                                );
                                            showCustomSnackbar(context,
                                                message: "Message Sent");
                                          }
                                          storyCommentTextController.clear();
                                          _commentFocusNode.unfocus();
                                        },
                                        onStoryLiked: () {
                                          context
                                              .read<ViewStoryCubit>()
                                              .likeOtherStory(
                                                  currentActiveUser?.userId ??
                                                      "",
                                                  currentActiveUser?.storyId ??
                                                      "");
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          );
                        },
                      );
                    },
                    indicatorAnimationController: indicatorAnimationController,
                    initialStoryIndex: (_) => 0,
                    pageLength: stories?.length ?? 0,
                    storyLength: (int pageIndex) {
                      return stories?[pageIndex].storiesUrl.length ?? 0;
                    },
                    onPageLimitReached: () {
                      Navigator.pop(context);
                    },
                  )
                : const Center(
                    child: Text(
                      "Oops! No Stories available,",
                      style: AppTheme.simpleBodyText,
                    ),
                  ),
          );
        },
      ),
    );
  }

  void _handleFocusChange() {
    if (_commentFocusNode.hasFocus) {
      // If the TextField gains focus (user starts typing) -> PAUSE the story
      if (indicatorAnimationController.value !=
          IndicatorAnimationCommand.pause) {
        indicatorAnimationController.value = IndicatorAnimationCommand.pause;
        print('Comment box focused. Story PAUSED.');
      }
    } else {
      // If the TextField loses focus (user submits, taps outside) -> RESUME the story
      if (indicatorAnimationController.value !=
          IndicatorAnimationCommand.resume) {
        indicatorAnimationController.value = IndicatorAnimationCommand.resume;
        print('Comment box unfocused. Story RESUMED.');
      }
    }
  }
}
