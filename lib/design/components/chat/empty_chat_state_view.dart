import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/chat/people_venn_view.dart';

class EmptyChatStateView extends StatelessWidget {
  const EmptyChatStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Stack(
        children: [
          Image.asset(
              'lib/assets/images/event/movie_card_illustration.png',
              fit: BoxFit.cover),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProfileVennDiagram(
                  profilePhoto1Url: 'https://picsum.photos/200',
                  profilePhoto2Url: 'https://picsum.photos/200',
                  logoUrl: 'lib/assets/icons/glint_logo.svg',
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Got an Event match\nwith Gajgamini',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Wait for Gajgamini to message you!',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: const Text(
                    'Upgrade Plan Now',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
