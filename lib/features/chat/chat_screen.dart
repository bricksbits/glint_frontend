import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/chat/chat_with_screen.dart';
import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    channelStateSort: const [SortOption('last_message_at')],
    limit: 20,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stories'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
          const Gap(16),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStoriesSection(),
          _buildRecentMatchesSection(),
          const Divider(),
          const Text(
            'Chats',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 18),
          ),
          Expanded(
            child: StreamChannelListView(
              controller: _listController,
              itemBuilder: (context, channels, index, defaultTile) {
                // final lastMessage = channels[index].state?.messages.last;
                // final unreadCount = channels[index].state?.unreadCount ?? 0;
                // final myUserId = StreamChat.of(context).currentUser?.id ?? 0;
                // //
                // // // Determine if the last message was sent by the opposite user and is unread
                // final isUnreadFromOtherUser = lastMessage != null &&
                //     lastMessage.user?.id != myUserId &&
                //     unreadCount > 0;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(channels[index].image ?? ''),
                  ),
                  title: Text(
                    channels[index].name ?? 'Chat',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'No messages yet',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: true
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Your Turn',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StreamChannel(
                          channel: channels[index],
                          child: const ChatWithScreen(
                              // channel: channels[index],
                              ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentMatchesSection() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: matches.length,
        itemBuilder: (context, index) {
          var match = matches[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(match['image'],
                          width: 70, height: 70, fit: BoxFit.cover),
                    ),
                    if (match.containsKey('icon'))
                      Positioned(
                        bottom: 5,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 12,
                          child: Icon(match['icon'],
                              size: 14, color: Colors.black),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(match['name']),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoriesSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          padding: const EdgeInsets.all(4),
          itemBuilder: (context, index) {
            var story = stories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      GradientCircularProgressIndicator(
                        progress: 100,
                        gradient: AppColours.circularProgressGradient,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                            story['image'],
                          ),
                        ),
                      ),
                      if (story.containsKey('likes'))
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 12,
                            child: Text('${story['likes']}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(story['name']),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> matches = [
  {
    'name': 'Rakhi',
    'image': 'lib/assets/images/temp_place_holder.png',
    'icon': Icons.favorite
  },
  {
    'name': 'Dimpy',
    'image': 'lib/assets/images/temp_place_holder.png',
    'icon': Icons.pets
  },
  {'name': 'Shreya', 'image': 'lib/assets/images/temp_place_holder.png'},
  {'name': 'Kathie', 'image': 'lib/assets/images/temp_place_holder.png'},
  {
    'name': 'Rakhi',
    'image': 'lib/assets/images/temp_place_holder.png',
    'icon': Icons.favorite
  },
  {
    'name': 'Dimpy',
    'image': 'lib/assets/images/temp_place_holder.png',
    'icon': Icons.pets
  },
  {'name': 'Shreya', 'image': 'lib/assets/images/temp_place_holder.png'},
  {'name': 'Kathie', 'image': 'lib/assets/images/temp_place_holder.png'},
  {
    'name': 'Rakhi',
    'image': 'lib/assets/images/temp_place_holder.png',
    'icon': Icons.favorite
  },
  {
    'name': 'Dimpy',
    'image': 'lib/assets/images/temp_place_holder.png',
    'icon': Icons.pets
  },
  {'name': 'Shreya', 'image': 'lib/assets/images/temp_place_holder.png'},
  {'name': 'Kathie', 'image': 'lib/assets/images/temp_place_holder.png'},
];
List<Map<String, dynamic>> stories = [
  {
    'name': 'You',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 1.0
  },
  {
    'name': 'Shalini',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 0.7,
    'likes': 3
  },
  {
    'name': 'Riya',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 0.5,
    'likes': 1
  },
  {
    'name': 'Shreya',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 0.9,
    'likes': 4
  },
  {
    'name': 'You',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 1.0
  },
  {
    'name': 'Shalini',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 0.7,
    'likes': 3
  },
  {
    'name': 'Riya',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 0.5,
    'likes': 1
  },
  {
    'name': 'Shreya',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 0.9,
    'likes': 4
  },
  {
    'name': 'You',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 1.0
  },
  {
    'name': 'Shalini',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 0.7,
    'likes': 3
  },
  {
    'name': 'Riya',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 0.5,
    'likes': 1
  },
  {
    'name': 'Shreya',
    'image': 'lib/assets/images/temp_place_holder.png',
    'progress': 0.9,
    'likes': 4
  },
];
