import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/chat/story_comment_like.dart';
import 'package:glint_frontend/features/chat/chat_screen_cubit.dart';
import 'package:glint_frontend/features/chat/story/view/view_story_cubit.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';

class ViewStoryScreen extends StatefulWidget {
  const ViewStoryScreen({super.key, required this.passedIndex});

  final int passedIndex;

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  final customPronounsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewStoryCubit(),
      child: BlocBuilder<ViewStoryCubit, ViewStoryState>(
        builder: (context, state) {
          return Scaffold(
            body: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : StoryPageView(
                    itemBuilder: (context, pageIndex, storyIndex) {
                      final currentVisibleUser = state.stories?[pageIndex];
                      final currentVisibleStory =
                          currentVisibleUser?.storiesUrl[storyIndex];
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: Container(color: Colors.black),
                          ),
                          // TODO(GO): Put the Error Builder here
                          Positioned.fill(
                            child: StoryImage(
                              key: ValueKey(currentVisibleStory),
                              imageProvider: NetworkImage(
                                currentVisibleStory ?? "",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 44, left: 8),
                            child: Row(
                              children: [
                                Container(
                                  height: 32,
                                  width: 32,
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
                                Text(
                                  currentVisibleUser?.username ?? "User",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "AlbertSans",
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppColours.primaryBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        color: Colors.white,
                                        icon: const Icon(Icons.bolt),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Gap(4),
                                      Text(
                                        currentVisibleUser?.streakCount ?? "",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "AlbertSans",
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    gestureItemBuilder: (context, pageIndex, storyIndex) {
                      return LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Stack(
                            children: [
                              Positioned(
                                left: 32,
                                top: 32,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              const Positioned(
                                bottom: 24,
                                left: 24,
                                right: 24,
                                child: StoryCommentTextInput(),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    indicatorAnimationController: indicatorAnimationController,
                    initialStoryIndex: (pageIndex) {
                      return pageIndex;
                    },
                    pageLength: state.stories?.length ?? 0,
                    storyLength: (int pageIndex) {
                      return state.stories?[pageIndex].storiesUrl.length ?? 0;
                    },
                    onPageLimitReached: () {
                      Navigator.pop(context);
                    },
                  ),
          );
        },
      ),
    );
  }
}
