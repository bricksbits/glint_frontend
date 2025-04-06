import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      backgroundColor: AppColours.white,
      appBar: AppBar(
        backgroundColor: AppColours.white,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 20,
        title: Text(
          "Stories",
          style: AppTheme.headingThree.copyWith(
            fontStyle: FontStyle.normal,
          ),
        ),
        actionsPadding: const EdgeInsets.only(right: 20.0),
        actions: [
          GestureDetector(
            onTap: () {
              // todo - add heart clicked functionality
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint_heart.svg',
            ),
          ),
          const Gap(18.0),
          GestureDetector(
            onTap: () {
              // todo - add heart clicked functionality
            },
            child: SvgPicture.asset(
              'lib/assets/icons/upload_story.svg',
            ),
          ),
        ],
      ),
      body: FutureBuilder<Channel>(
        future:
            initializeChat(StreamChat.of(context).client, 'your_channel_id'),
        // Call your async method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final channel = snapshot.data!;
            return StreamChannel(
              channel: channel,
              child: Column(
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
                            backgroundImage:
                                NetworkImage(channels[index].image ?? ''),
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
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  Widget _buildRecentMatchesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Matches",
          style: AppTheme.headingThree.copyWith(
            fontStyle: FontStyle.normal,
          ),
        ),
        const Gap(2.0),
        const Text(
          'Start conversation to find your spark',
          style: AppTheme.simpleText,
        ),
        const Gap(6.0),
        SizedBox(
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
        ),
      ],
    );
  }

  Widget _buildStoriesSection() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColours.white,
        border: Border(
          bottom: BorderSide(
            color: AppColours.borderGray,
            width: 1.2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0).copyWith(bottom: 0),
        child: SizedBox(
          height: 128.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: stories.length,
            padding: const EdgeInsets.all(4),
            itemBuilder: (context, index) {
              var story = stories[index];
              return Container(
                padding: const EdgeInsets.only(right: 16.0),
                margin: index == 0 ? const EdgeInsets.only(left: 16.0) : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        GradientCircularProgressIndicator(
                          progress: 100,
                          stroke: 3.6,
                          gradient: AppColours.circularProgressGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 36,
                              backgroundImage: AssetImage(
                                story['image'],
                              ),
                            ),
                          ),
                        ),
                        if (story.containsKey('likes'))
                          Positioned(
                            bottom: -8.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 3.6),
                              decoration: BoxDecoration(
                                color: AppColours.primaryBlue,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.local_fire_department,
                                    size: 14,
                                    color: AppColours.white,
                                  ),
                                  const Gap(2.0),
                                  Text(
                                    '${story['likes']}',
                                    style: AppTheme.smallBodyText.copyWith(
                                      color: AppColours.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Gap(12.0),
                    Text(
                      story['name'],
                      style: AppTheme.simpleText.copyWith(
                        color: AppColours.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
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
      'name': 'Dimpy',
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

  Future<Channel> initializeChat(
      StreamChatClient client, String channelId) async {
    final channel = client.channel('messaging', id: 'flutterdevs');
    await channel.watch();
    return channel;
  }
}
