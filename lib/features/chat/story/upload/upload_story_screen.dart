import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/features/chat/story/upload/upload_story_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

//Todo: Implement the Mechanism to watch user own stories,
// Once Uploaded, Move to the Chat Screen.
class UploadStoryScreen extends StatefulWidget {
  final bool isUploadStory;

  const UploadStoryScreen({
    super.key,
    required this.isUploadStory,
  });

  @override
  State<UploadStoryScreen> createState() => _UploadStoryScreenState();
}

class _UploadStoryScreenState extends State<UploadStoryScreen> {
  @override
  void initState() {
    super.initState();

    // context.read<UploadStoryBloc>().capturePassArgument(
    //       widget.isUploadStory,
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadStoryBloc(),
      child: BlocListener<UploadStoryBloc, UploadStoryState>(
        listenWhen: (prev, current) =>
            prev.isUploadingStoryEvent != current.isUploadingStoryEvent,
        listener: (context, state) {
          if (state.isUploadingStoryEvent) {
            context.pop();
          }
        },
        child: BlocBuilder<UploadStoryBloc, UploadStoryState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.black, // fallback bg
              body: Stack(
                children: [
                  /// Background Story Image or Placeholder
                  Positioned.fill(
                    child: widget.isUploadStory
                        ? state.currentUploadedFile != null
                            ? Image.file(state.currentUploadedFile!)
                            : Container(
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: Text('Please, select a story.'),
                                ),
                              )
                        : Image.network(
                            state.uploadedStories?.storiesUrl.first ?? "",
                            fit: BoxFit.cover),
                  ),

                  /// Top user info + delete
                  Positioned(
                    top: 40,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                state
                                    .userCircularAvatarUrl, // Replace with real URL or asset
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Text(state.userName,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified,
                                    color: Colors.white, size: 16),
                              ],
                            ),
                          ],
                        ),
                        if (!widget.isUploadStory)
                          IconButton(
                            onPressed: () {
                              context.read<UploadStoryBloc>().add(
                                  const UploadStoryEvent.deleteUserStory(
                                      "story_1"));
                            },
                            icon: const Icon(Icons.more_vert,
                                color: Colors.white),
                            tooltip: "Delete",
                          ),
                      ],
                    ),
                  ),

                  /// Bottom Area
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildUploadBar(
                      () {
                        state.currentUploadedFile != null
                            ? context
                                .read<UploadStoryBloc>()
                                .add(const UploadStoryEvent.uploadStory())
                            : context.read<UploadStoryBloc>().add(
                                const UploadStoryEvent
                                    .selectStoryFromGallery());
                      },
                      state.currentUploadedFile != null,
                    ),
                    // : _buildViewBar(
                    //     "lib/assets/icons/male.svg",
                    //     "lib/assets/icons/male.svg",
                    //     state.uploadedStories?.storiesUrl.first ?? "",
                    //   ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUploadBar(VoidCallback uploadStory, bool isUploadingStory) {
    final btnText = isUploadingStory ? "Upload Story now" : "Select Photo";
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: uploadStory,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(btnText, style: const TextStyle(color: Colors.white)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }

  /// Story views bar
  Widget _buildViewBar(
    String placeHolderUserOne,
    String placeHolderUserTwo,
    String storyViewCount,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.black.withOpacity(0.8),
      child: Row(
        children: [
          CircleAvatar(
              radius: 12, backgroundImage: AssetImage(placeHolderUserOne)),
          const SizedBox(width: 4),
          CircleAvatar(
              radius: 12, backgroundImage: AssetImage(placeHolderUserTwo)),
          const SizedBox(width: 8),
          Text('$storyViewCount views',
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
