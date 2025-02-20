import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint_frontend/design/components/chat/people_venn_view.dart';

class EmptyChatStateView extends StatelessWidget {
  final bool isEventMatch;
  final String matchUserId;
  final String matchUserName;
  final VoidCallback upgradePlanCallBack;

  const EmptyChatStateView({
    super.key,
    required this.isEventMatch,
    required this.matchUserId,
    required this.matchUserName,
    required this.upgradePlanCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensures it wraps its content
        children: [
          Stack(
            clipBehavior: Clip.none, // Allows images to overlap
            children: [
              // 🔹 Background Card with Image & Text
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(
                  'lib/assets/images/event/movie_card_illustration.png',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    const Text("Got an Event match with", style: TextStyle(fontSize: 16)),
                    const Text("Gajgamini", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 36),
                    const Text("Wait for Gajgamini to message you!", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              // 🔹 Venn Diagram Profile Images
              const Positioned(
                top: -40, // Moves the images partly outside the card
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Left User Image
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 34,
                        backgroundImage: NetworkImage('https://picsum.photos/200'),
                      ),
                    ),
                    // App Logo
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.favorite, color: Colors.purple),
                      ),
                    ),
                    // Right User Image
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 34,
                        backgroundImage: NetworkImage('https://picsum.photos/200'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 🔹 Bottom Buttons
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20)),
                  ),
                  child: const Center(
                    child: Text(
                      "Wanted to message first?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                  ),
                  child: const Center(
                    child: Text(
                      "Upgrade Plan Now",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
