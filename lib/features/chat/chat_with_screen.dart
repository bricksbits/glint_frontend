import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/chat/chat_circular_icon_button.dart';
import 'package:glint_frontend/design/components/chat/empty_chat_state_view.dart';
import 'package:glint_frontend/design/components/chat/get_ticket_gradient_view.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const String chatWithEventId = "CHAT_WITH_EVENT_ID";
const String chatWithEventName = "CHAT_WITH_EVENT_NAME";
const String chatWithEventStartTime = "CHAT_WITH_EVENT_START_TIME";

class ChatWithScreen extends StatefulWidget {
  final ChatWithNavArguments chatWithNavArguments;

  const ChatWithScreen({
    super.key,
    required this.chatWithNavArguments,
  });

  @override
  State<ChatWithScreen> createState() => _ChatWithScreenState();
}

class _ChatWithScreenState extends State<ChatWithScreen> {
  bool showSuggestions = false; // To toggle the suggestion box
  final StreamMessageInputController _messageInputController =
      StreamMessageInputController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeChat(
          StreamChat.of(context).client,
          widget.chatWithNavArguments,
        ),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(child: Text('Error: ${asyncSnapshot.error}'));
          } else if (asyncSnapshot.hasData) {
            final channel = asyncSnapshot.data;
            final oppositeUser = getOppositeUser(channel, context);
            final oppositeUserName = oppositeUser?.name ?? 'Chat';
            final oppositeUserImage = oppositeUser?.image ?? '';
            final eventId = channel?.extraData[chatWithEventId];
            final eventName = channel?.extraData[chatWithEventName];
            final eventStartTime = channel?.extraData[chatWithEventStartTime];

            return StreamChannel(
              channel: channel!,
              child: Scaffold(
                appBar: StreamChannelHeader(
                  showTypingIndicator: true,
                  showConnectionStateTile: true,
                  leading: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 4, bottom: 4, right: 4),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        oppositeUserImage,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        oppositeUserName ?? 'Chat',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                    eventId != null &&
                            eventName != null &&
                            eventStartTime != null
                        ? GetTicketGradientView(
                            eventName: eventName.toString(),
                            eventId: eventId.toString(),
                            eventDate: eventStartTime.toString(),
                            eventOffers: "",
                            onGetTicketClicked: () {
                              context.pushNamed(
                                GlintChatRoutes.getTicket.name,
                              );
                            },
                          )
                        : const SizedBox.shrink(),
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
                              matchUserName: oppositeUserName,
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
                                          isOneTimeView && !hasBeenViewed, () {
                                          context.pushNamed(
                                            GlintChatRoutes
                                                .oneTimePhotoView.name,
                                            extra: imageUrls.first,
                                          );
                                          hasBeenViewed = true;
                                        })
                                      : _buildMessageBubble(message, isMine),
                                ] else ...[
                                  hasAttachments
                                      ? _chatImageMessageBubble(
                                          isOneTimeView && !hasBeenViewed, () {
                                          context.pushNamed(
                                            GlintChatRoutes
                                                .oneTimePhotoView.name,
                                            extra: imageUrls.first,
                                          );
                                          hasBeenViewed = true;
                                        })
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
                    // AnimatedContainer(
                    //   duration: const Duration(milliseconds: 300),
                    //   height: showSuggestions ? 240 : 0,
                    //   child: showSuggestions
                    //       ? Container(
                    //           color: Colors.white,
                    //           padding: const EdgeInsets.symmetric(
                    //               vertical: 26, horizontal: 20),
                    //           child: ListView.builder(
                    //             scrollDirection: Axis.vertical,
                    //             itemCount: aiSuggestions.length,
                    //             itemBuilder: (context, index) {
                    //               return GestureDetector(
                    //                 onTap: () {
                    //                   _messageInputController.text =
                    //                       aiSuggestions[index]; // Set text
                    //                   setState(() {
                    //                     showSuggestions = false;
                    //                   });
                    //                 },
                    //                 child: Card(
                    //                   elevation: 2,
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.all(8),
                    //                     child: Text(
                    //                       aiSuggestions[index],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         )
                    //       : const SizedBox(),
                    // ),
                    StreamMessageInput(
                      messageInputController: _messageInputController,
                      sendButtonLocation: SendButtonLocation.outside,
                      actionsLocation: ActionsLocation.left,
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
                            svgAssetPath: "lib/assets/icons/upload_story.svg",
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
                          // chatCircularIconButton(
                          //   svgAssetPath: "lib/assets/icons/direct_msg.svg",
                          //   padding: const EdgeInsets.all(8),
                          //   onPressed: () {
                          //     setState(() {
                          //       showSuggestions = !showSuggestions;
                          //     });
                          //   },
                          //   radius: 16,
                          // ),
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

  // Inside your ChatWithScreen, or in a utility file
  User? getOppositeUser(Channel? channel, BuildContext context) {
    final currentUserId = StreamChat.of(context).currentUser?.id;

    if (currentUserId == null) return null;

    // Find the member whose ID is NOT the current user's ID
    final oppositeMember = channel?.state?.members.firstWhere(
      (member) => member.userId != currentUserId,
      orElse: () => Member(), // Return an empty Member if not found
    );

    return oppositeMember?.user;
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
    StreamChatClient client,
    ChatWithNavArguments chatWithArguments,
  ) async {
    final channel = client.channel(
      'messaging',
      id: chatWithArguments.channelId,
      extraData: {
        chatWithEventId: chatWithArguments.eventId,
        chatWithEventName: chatWithArguments.eventName,
        chatWithEventStartTime: chatWithArguments.eventStartTime,
      },
    );
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
    VoidCallback hasBeenWatched,
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
                  onTap: hasBeenWatched,
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
