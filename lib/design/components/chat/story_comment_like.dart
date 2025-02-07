import 'package:flutter/material.dart';

class StoryCommentTextInput extends StatefulWidget {
  const StoryCommentTextInput({super.key});

  @override
  State<StoryCommentTextInput> createState() => _StoryCommentTextInputState();
}

class _StoryCommentTextInputState extends State<StoryCommentTextInput> {
  bool _isLiked = false; // Track like state
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded( // TextField takes up available space
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              border: OutlineInputBorder( // Optional border
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16), // Adjust padding as needed
            ),

          ),
        ),
        IconButton( // Like button
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

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller
    super.dispose();
  }
}