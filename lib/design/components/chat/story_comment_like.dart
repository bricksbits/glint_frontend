import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_theme.dart';

class StoryCommentTextInput extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController storyCommentController;
  final VoidCallback onCommentSend;
  final VoidCallback onStoryLiked;

  const StoryCommentTextInput({
    super.key,
    required this.focusNode,
    required this.storyCommentController,
    required this.onCommentSend,
    required this.onStoryLiked,
  });

  @override
  State<StoryCommentTextInput> createState() => _StoryCommentTextInputState();
}

class _StoryCommentTextInputState extends State<StoryCommentTextInput> {
  bool _isLiked = false; // Track like state

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              // TextField takes up available space
              child: TextField(
                cursorColor: Colors.white,
                focusNode: widget.focusNode,
                controller: widget.storyCommentController,
                style: AppTheme.simpleBodyText.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  hintStyle: AppTheme.smallBodyText.copyWith(color: Colors.white),
                  labelStyle: AppTheme.smallBodyText.copyWith(color: Colors.white),
                  hintText: 'Write a comment...',
                  border: OutlineInputBorder(
                    // Optional border
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16), // Adjust padding as needed
                ),
              ),
            ),
            IconButton(
              // Like button
              onPressed: widget.onCommentSend,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
            IconButton(
              // Like button
              onPressed: () {
                widget.onStoryLiked();
                setState(() {
                  _isLiked = !_isLiked;
                });
              },
              icon: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                color: _isLiked ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
