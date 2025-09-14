import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/chat/chat_circular_icon_button.dart';
import 'package:glint_frontend/design/components/chat/empty_chat_state_view.dart';
import 'package:glint_frontend/design/components/chat/get_ticket_gradient_view.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatWithScreen extends StatefulWidget {
  final String channelId;

  const ChatWithScreen({
    super.key,
    required this.channelId,
  });

  @override
  State<ChatWithScreen> createState() => _ChatWithScreenState();
}

class _ChatWithScreenState extends State<ChatWithScreen> {
  bool showSuggestions = false; // To toggle the suggestion box
  final StreamMessageInputController _messageInputController =
      StreamMessageInputController();

  // Dummy AI-generated messages
  List<String> aiSuggestions = [
    "Hey! How's your day going?",
    "That sounds interesting! Tell me more.",
    "Haha, that's funny!",
    "I'm not sure, what do you think?",
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeChat(
          StreamChat.of(context).client,
          widget.channelId,
        ),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(child: Text('Error: ${asyncSnapshot.error}'));
          } else if (asyncSnapshot.hasData) {
            final channel = asyncSnapshot.data;
            return StreamChannel(
              channel: channel!,
              child: Scaffold(
                appBar: StreamChannelHeader(
                  showTypingIndicator: true,
                  showConnectionStateTile: true,
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          scale: 0.3,
                          channel.image ?? '',
                        ),
                      ),
                      const Gap(8),
                      Text(
                        channel.name ?? 'Chat',
                        // Display channel name
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                  centerTitle: false,
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
                    GetTicketGradientView(
                      eventName: "Get Stream Party",
                      eventId: "32",
                      eventDate: "15 May, 2025",
                      eventOffers: "100% Off on Dev Mode",
                      onGetTicketClicked: () {
                        context.pushNamed(GlintChatRoutes.getTicket.name);
                      },
                    ),
                    Expanded(
                      child: StreamMessageListView(
                        loadingBuilder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        emptyBuilder: (context) {
                          return Center(
                            child: EmptyChatStateView(
                              isEventMatch: false,
                              matchUserId: "0",
                              matchUserName: "Gajini",
                              upgradePlanCallBack: () {},
                            ),
                          );
                        },
                        errorBuilder: (context, error) {
                          return Center(
                            child: Text("Something went wrong here $error"),
                          );
                        },
                        messageBuilder:
                            (context, details, messages, defaultMessage) {
                          final message = details.message;
                          final isMine = details.isMyMessage;
                          final attachments = details.message.attachments;
                          bool hasAttachments = attachments.isNotEmpty;
                          bool isOneTimeView = true;
                          bool hasBeenViewed = false;
                          final imageUrls =
                              attachments.map((file) => file.imageUrl).toList();

                          if (hasAttachments) {
                            final imageReceived = attachments.first;
                            isOneTimeView =
                                imageReceived.extraData['one_time_view'] ==
                                    true;
                            hasBeenViewed =
                                imageReceived.extraData['viewed'] == true;
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: isMine
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (isMine) ...[
                                  // Time on the left for receiver
                                  Text(
                                    DateFormat('h:mm a')
                                        .format(message.createdAt.toLocal()),
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                  const SizedBox(width: 8),
                                  hasAttachments
                                      ? _chatImageMessageBubble(
                                          isOneTimeView && !hasBeenViewed,
                                          imageUrls.first,
                                        )
                                      : _buildMessageBubble(message, isMine),
                                ] else ...[
                                  hasAttachments
                                      ? _chatImageMessageBubble(
                                          isOneTimeView && !hasBeenViewed,
                                          imageUrls.first,
                                        )
                                      : _buildMessageBubble(message, isMine),
                                  const SizedBox(width: 8),
                                  // Time on the right for sender
                                  Text(
                                    DateFormat('h:mm a')
                                        .format(message.createdAt.toLocal()),
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                        dateDividerBuilder: (dateTime) {
                          return Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: Text(
                                getFormattedDate(DateTime.now()),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Animated AI Suggestions Box
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: showSuggestions ? 240 : 0,
                      child: showSuggestions
                          ? Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 26, horizontal: 20),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: aiSuggestions.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      _messageInputController.text =
                                          aiSuggestions[index]; // Set text
                                      setState(() {
                                        showSuggestions = false;
                                      });
                                    },
                                    child: Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          aiSuggestions[index],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const SizedBox(),
                    ),
                    StreamMessageInput(
                      messageInputController: _messageInputController,
                      sendButtonLocation: SendButtonLocation.inside,
                      actionsLocation: ActionsLocation.leftInside,
                      sendButtonBuilder: (context, textController) {
                        return chatCircularIconButton(
                          svgAssetPath: "lib/assets/icons/direct_msg.svg",
                          radius: 20,
                          padding: const EdgeInsets.all(8),
                          onPressed: () async {
                            Message? framedMessage;

                            /// For Text Messages
                            if (_messageInputController.text.isNotEmpty &&
                                _messageInputController.attachments.isEmpty) {
                              framedMessage = Message(
                                id: DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString(),
                                type: MessageType.regular,
                                text: _messageInputController.text,
                              );
                            }

                            /// For Images with no Context
                            if (_messageInputController.text.isEmpty &&
                                _messageInputController
                                    .attachments.isNotEmpty) {
                              final selectedImage = _messageInputController
                                  .attachments.first.file;
                              if (selectedImage != null) {
                                framedMessage = Message(
                                  id: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  type: MessageType.regular,
                                  attachments:
                                      _messageInputController.attachments,
                                );
                              }
                            }

                            /// For Images and Text
                            if (_messageInputController.text.isNotEmpty &&
                                _messageInputController
                                    .attachments.isNotEmpty) {
                              final selectedImage = _messageInputController
                                  .attachments.first.file;
                              if (selectedImage != null) {
                                framedMessage = Message(
                                  id: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  attachments:
                                      _messageInputController.attachments,
                                  text: _messageInputController.text,
                                );
                              }
                            }

                            if (framedMessage != null) {
                              channel.sendMessage(framedMessage);
                              _messageInputController.clear();
                            }
                          },
                        );
                      },
                      attachmentLimit: 1,
                      useSystemAttachmentPicker: true,
                      actionsBuilder: (context, listOfWidgets) {
                        return [
                          chatCircularIconButton(
                            svgAssetPath: "lib/assets/icons/direct_msg.svg",
                            radius: 16,
                            padding: const EdgeInsets.all(8),
                            onPressed: () async {
                              final attachmentHandler =
                                  StreamAttachmentHandler.instance;
                              final result = await attachmentHandler.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (result != null && result.file != null) {
                                _messageInputController.addAttachment(
                                    Attachment(
                                        file: result.file,
                                        type: 'image',
                                        extraData: const {
                                      'one_time_view': true,
                                      'viewed': false,
                                    }));
                              }
                            },
                          ),
                          chatCircularIconButton(
                            svgAssetPath: "lib/assets/icons/direct_msg.svg",
                            padding: const EdgeInsets.all(8),
                            onPressed: () {
                              setState(() {
                                showSuggestions = !showSuggestions;
                              });
                            },
                            radius: 16,
                          ),
                        ];
                      },
                      allowedAttachmentPickerTypes: const [
                        AttachmentPickerType.images,
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Servers down, please try again, later'),
            );
          }
        });
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    super.dispose();
  }

  String getFormattedDate(DateTime currentTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate =
        DateTime(currentTime.year, currentTime.month, currentTime.day);
    final difference = today.difference(messageDate).inDays;

    if (difference == 0) {
      return 'TODAY';
    } else if (difference == 1) {
      return 'YESTERDAY';
    } else {
      return DateFormat('EEEE, dd MMM').format(currentTime);
    }
  }

  Widget _buildMessageBubble(Message message, bool isMine) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      constraints: const BoxConstraints(maxWidth: 250),
      decoration: BoxDecoration(
        color: isMine ? Colors.blue.shade50 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        message.text ?? '',
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Future<Channel> initializeChat(
      StreamChatClient client, String channelId) async {
    final channel = client.channel('messaging', id: channelId);
    await channel.watch();
    return channel;
  }

  Widget _buildTime(Message message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        DateFormat('h:mm a').format(message.createdAt.toLocal()),
        style: const TextStyle(fontSize: 10, color: Colors.grey),
      ),
    );
  }

  /// This is an complicated Widget Block which does those following jobs:
  /// Handle the Alignment of the Message,
  /// Handles the One Time view of the Media Files
  Widget _chatImageMessageBubble(
    bool allowImage,
    String? imageUrl,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(0), // No radius here
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Placeholder Icon (replace with your image icon later)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child:
                const Icon(Icons.image_outlined, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          allowImage
              ? GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      GlintChatRoutes.oneTimePhotoView.name,
                      extra: imageUrl,
                    );
                  },
                  child: const Text(
                    'Photo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : const Text(
                  'Viewed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ],
      ),
    );
  }
}
