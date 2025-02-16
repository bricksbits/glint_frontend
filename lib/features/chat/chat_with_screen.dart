import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/chat/chat_ticket_info_view.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatWithScreen extends StatefulWidget {
  final Channel channel;

  const ChatWithScreen({super.key, required this.channel});

  @override
  State<ChatWithScreen> createState() => _ChatWithScreenState();
}

class _ChatWithScreenState extends State<ChatWithScreen> {
  bool showSuggestions = false; // To toggle the suggestion box
  final TextEditingController _controller = TextEditingController();

  // Dummy AI-generated messages
  List<String> aiSuggestions = [
    "Hey! How's your day going?",
    "That sounds interesting! Tell me more.",
    "Haha, that's funny!",
    "I'm not sure, what do you think?",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamChannelHeader(
        leading: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8, // Keep it compact
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(), // Back button
              ),
              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //     widget.channel.image ?? '',
              //   ),
              // ),
            ],
          ),
        ),
        title: Text(
          widget.channel.name ?? 'Chat', // Display channel name
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        showConnectionStateTile: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {
              // Handle call action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamMessageListView(
              loadingBuilder: (context) {
                return const Text('Loading Builder');
              },
              emptyBuilder: (context) {
                return const Center(
                  child: ChatTicketInfoView(),
                );
              },
              errorBuilder: (context, error) {
                return Text("Something went wrong here $error");
              },
            ),
          ),
          // Animated AI Suggestions Box
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: showSuggestions ? 300 : 0, // Expand or collapse
            child: showSuggestions
                ? Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      itemCount: aiSuggestions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _controller.text = aiSuggestions[index]; // Set text
                            setState(() {
                              showSuggestions = false; // Hide suggestions
                            });
                          },
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(aiSuggestions[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ),
          StreamMessageInput(
            sendButtonBuilder: (context, textController) {
              return IconButton(onPressed: () {}, icon: const Icon(Icons.add));
            },
            actionsBuilder: (context, listOfWidgets) {
              return [
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        showSuggestions = !showSuggestions;
                      });
                    },
                    icon: const Icon(Icons.add))
              ];
            },
            allowedAttachmentPickerTypes: const [
              AttachmentPickerType.images,
            ],
          ),
        ],
      ),
    );
  }
}
