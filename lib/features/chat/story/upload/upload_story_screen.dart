import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class UploadStoryScreen extends StatelessWidget {
  final bool hasStory; // true if image is uploaded
  final String imageUrl; // from state
  final int viewsCount;
  final VoidCallback onDelete;
  final VoidCallback onUpload;

  const UploadStoryScreen(
      {super.key,
      required this.hasStory,
      required this.imageUrl,
      required this.viewsCount,
      required this.onDelete,
      required this.onUpload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // fallback bg
      body: Stack(
        children: [
          /// Background Story Image or Placeholder
          Positioned.fill(
            child: hasStory
                ? Image.network(imageUrl, fit: BoxFit.cover)
                : Container(
              color: Colors.grey.shade300,
              child: const Center(child: Text('No Story Uploaded')),
            ),
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
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        'https://your-avatar-url.com', // Replace with real URL or asset
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: const [
                        Text("Shubham",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Icons.verified, color: Colors.white, size: 16),
                      ],
                    ),
                  ],
                ),
                if (hasStory)
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.more_vert, color: Colors.white),
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
            child: hasStory ? _buildViewBar(context) : _buildUploadBar(context),
          ),
        ],
      ),
    );
  }

  /// Upload story UI
  Widget _buildUploadBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onUpload,
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
  Widget _buildViewBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.black.withOpacity(0.8),
      child: Row(
        children: [
          const CircleAvatar(radius: 12, backgroundImage: AssetImage("assets/user1.png")),
          const SizedBox(width: 4),
          const CircleAvatar(radius: 12, backgroundImage: AssetImage("assets/user2.png")),
          const SizedBox(width: 8),
          Text('$viewsCount views', style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
