import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/features/chat/story/upload/upload_story_bloc.dart';

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
                      : Image.network(state.uploadedStories.first.storyUrl,
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
                          icon:
                              const Icon(Icons.more_vert, color: Colors.white),
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
                  child: widget.isUploadStory
                      ? _buildUploadBar(
                          () => context.read<UploadStoryBloc>().add(
                              const UploadStoryEvent.selectStoryFromGallery()),
                        )
                      : _buildViewBar(
                          "lib/assets/icons/male.svg",
                          "lib/assets/icons/male.svg",
                          state.uploadedStories.first.storyViewCount),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Upload story UI
  Widget _buildUploadBar(
    VoidCallback uploadStory,
  ) {
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Upload Story", style: TextStyle(color: Colors.white)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.white),
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
