import 'package:flutter/material.dart';

class StoryCommentTextInput extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController storyCommentController;
  final VoidCallback onCommentSend;

  const StoryCommentTextInput({
    super.key,
    required this.focusNode,
    required this.storyCommentController,
    required this.onCommentSend,
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
    return Row(
      children: [
        Expanded(
          // TextField takes up available space
          child: TextField(
            focusNode: widget.focusNode,
            controller: widget.storyCommentController,
            decoration: InputDecoration(
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
          ),
        ),
        IconButton(
          // Like button
          onPressed: () {
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
    );
  }
}
