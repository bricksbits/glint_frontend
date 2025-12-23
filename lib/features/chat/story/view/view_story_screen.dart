import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/components/chat/story_comment_like.dart';
import 'package:glint_frontend/features/chat/chat_screen_cubit.dart';
import 'package:glint_frontend/features/chat/story/view/view_story_cubit.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ViewStoryScreen extends StatefulWidget {
  const ViewStoryScreen({super.key, required this.passedIndex});

  final int passedIndex;

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
    final streamClient = StreamChat.of(context).client;
    return BlocProvider(
      create: (context) => ViewStoryCubit(),
      child: BlocBuilder<ViewStoryCubit, ViewStoryState>(
        builder: (context, state) {
          return Scaffold(
            body: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.stories?.isNotEmpty == true
                    ? StoryPageView(
                        showShadow: true,
                        itemBuilder: (context, pageIndex, storyIndex) {
                          final currentVisibleUser = state.stories?[pageIndex];
                          currentChannel = currentVisibleUser?.streamChannelId;
                          final currentVisibleStory =
                              currentVisibleUser?.storiesUrl[storyIndex];
                          return Stack(
                            children: [
                              Positioned.fill(
                                child: Container(color: Colors.black),
                              ),
                              Positioned.fill(
                                child: StoryImage(
                                  key: ValueKey(currentVisibleStory),
                                  imageProvider: NetworkImage(
                                    currentVisibleStory ?? "",
                                  ),
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return Image.asset(
                                      fit: BoxFit.cover,
                                      'lib/assets/images/temp_place_holder.png',
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 44, left: 8),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   height: 32,
                                    //   width: 32,
                                    //   decoration: BoxDecoration(
                                    //     image: DecorationImage(
                                    //       image: NetworkImage(
                                    //           currentVisibleUser?.userImageUrl ??
                                    //               ""),
                                    //       fit: BoxFit.cover,
                                    //     ),
                                    //     shape: BoxShape.circle,
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColours.black,
                                        borderRadius:
                                            BorderRadiusGeometry.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          currentVisibleUser?.username ??
                                              "",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "AlbertSans",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Gap(4),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: AppColours.primaryBlue,
                                    //       borderRadius:
                                    //           BorderRadiusGeometry.circular(
                                    //               10.0)),
                                    //   child: Row(
                                    //     mainAxisSize: MainAxisSize.min,
                                    //     children: [
                                    //       IconButton(
                                    //         padding: EdgeInsets.zero,
                                    //         color: Colors.white,
                                    //         icon: const Icon(Icons.bolt),
                                    //         onPressed: () {
                                    //           Navigator.pop(context);
                                    //         },
                                    //       ),
                                    //       Text(
                                    //         currentVisibleUser?.streakCount ??
                                    //             "",
                                    //         style: const TextStyle(
                                    //           fontSize: 14,
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontFamily: "AlbertSans",
                                    //         ),
                                    //       ),
                                    //       const Gap(16),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        gestureItemBuilder: (context, pageIndex, storyIndex) {
                          return LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Stack(
                                children: [
                                  Positioned(
                                    left: 8,
                                    top: 44,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      color: Colors.black,
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 24,
                                    left: 24,
                                    right: 24,
                                    child: StoryCommentTextInput(
                                      focusNode: _commentFocusNode,
                                      storyCommentController:
                                          storyCommentTextController,
                                      onCommentSend: () {
                                        if (currentChannel != null) {
                                          final channel = streamClient.channel(
                                            'messaging',
                                            id: currentChannel,
                                          );
                                          context
                                              .read<ViewStoryCubit>()
                                              .replyToStory(
                                                streamClient,
                                                channel,
                                                storyCommentTextController.text,
                                              );
                                        }
                                        storyCommentTextController.clear();
                                        _commentFocusNode.unfocus();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        indicatorAnimationController:
                            indicatorAnimationController,
                        initialStoryIndex: (pageIndex) {
                          return pageIndex;
                        },
                        pageLength: state.stories?.length ?? 0,
                        storyLength: (int pageIndex) {
                          return state.stories?[pageIndex].storiesUrl.length ??
                              0;
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
