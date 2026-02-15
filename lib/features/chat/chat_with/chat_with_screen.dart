import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/components/chat/chat_circular_icon_button.dart';
import 'package:glint_frontend/design/components/chat/empty_chat_state_view.dart';
import 'package:glint_frontend/design/components/chat/get_ticket_gradient_view.dart';
import 'package:glint_frontend/features/chat/chat_with/chat_with_cubit.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

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
  final StreamMessageInputController _messageInputController =
      StreamMessageInputController();

  @override
  void initState() {
    context.read<ChatWithCubit>().connectToChannel(widget.chatWithNavArguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatWithCubit, ChatWithState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!state.chatAvailable) {
          return Center(
            child: Text(state.error.toString()),
          );
        }

        return state.chatAvailable
            ? StreamChannel(
                channel: state.currentChannel!,
                child: Scaffold(
                  appBar: setupHeader(
                    state.oppositeUserDetails?.name ?? "User",
                    state.oppositeUserDetails?.image ?? "",
                  ),
                  body: Column(
                    children: [
                      state.chatNavArgs?.eventId != null &&
                              state.chatNavArgs?.eventName != null &&
                              state.chatNavArgs?.eventStartTime != null
                          ? GetTicketGradientView(
                              eventName:
                                  state.chatNavArgs!.eventName.toString(),
                              eventId: state.chatNavArgs!.eventId.toString(),
                              eventDate:
                                  state.chatNavArgs!.eventStartTime.toString(),
                              eventOffers: "",
                              onGetTicketClicked: () {
                                context.pushNamed(
                                  GlintChatRoutes.getTicket.name,
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: getMessageListView(
                            state.oppositeUserDetails?.name ?? "Chat"),
                      ),
                      setupMessageInput(state.currentChannel),
                    ],
                  ),
                ),
              )
            : const Center(
                child: Text('Servers down, please try again, later'),
              );
      },
    );
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    context.read<ChatWithCubit>().closeChannel();
    super.dispose();
  }

  // ------------------- Main Components --------------------------------
  // ------------------- App Bar ----------------------------

  StreamChannelHeader setupHeader(
    String oppositeUserName,
    String oppositeUserImageUrl,
  ) {
    return StreamChannelHeader(
      showTypingIndicator: true,
      showConnectionStateTile: true,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              context.pop();
            },
          ),
          GestureDetector(
            onTap: () {
              GlintAnalyticService.onUserThumbnailClickedEvent(
                widget.chatWithNavArguments.matchId ?? "--",
              );
            },
            child: CircleAvatar(
              radius: 16,
              //todo: Add the loading and Error builder
              backgroundImage: NetworkImage(
                oppositeUserImageUrl,
              ),
            ),
          ),
        ],
      ),
      title: Row(
        children: [
          Text(
            oppositeUserName,
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
            GlintAnalyticService.onVideoCallClickedEvent(
              widget.chatWithNavArguments.channelId,
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            GlintAnalyticService.onSettingIconMenuClickedEvent(
                widget.chatWithNavArguments.channelId,
                "--",
                widget.chatWithNavArguments.matchId ?? "--");
          },
        ),
      ],
    );
  }

  // ------------------- Message List View ----------------------------
  StreamMessageListView getMessageListView(
    String oppositeUserName,
  ) {
    return StreamMessageListView(
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
      messageBuilder: (context, details, messages, defaultMessage) {
        final message = details.message;
        final isMine = details.isMyMessage;
        final attachments = details.message.attachments;
        bool hasAttachments = attachments.isNotEmpty;
        bool isOneTimeView = true;
        bool hasBeenViewed = false;
        final imageUrls = attachments.map((file) => file.imageUrl).toList();

        if (hasAttachments) {
          final imageReceived = attachments.first;
          isOneTimeView = imageReceived.extraData[oneTimeViewKey] == true;
          hasBeenViewed = imageReceived.extraData[viewedKey] == true;
        }

        final canViewPhoto =
            hasAttachments && !isMine && isOneTimeView && !hasBeenViewed;

        // Determine display state for the bubble
        final oneTimePhotoLabel = hasBeenViewed
            ? MediaMessageViewType.Viewed.name
            : MediaMessageViewType.Photo.name;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
                isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (isMine) ...[
                // Time on the left for receiver
                Text(
                  DateFormat('h:mm a').format(message.createdAt.toLocal()),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(width: 8),
                hasAttachments
                    ? _chatImageMessageBubble(
                        onImageMessageTap: () {
                          showCustomSnackbar(
                            context,
                            message: "Once sent, can't be viewed again.",
                          );
                        },
                        oneTimeViewPhotoLabel: oneTimePhotoLabel,
                      )
                    : _buildMessageBubble(message, isMine),
              ] else ...[
                hasAttachments
                    ? _chatImageMessageBubble(
                        onImageMessageTap: () {
                          context.pushNamed(
                            GlintChatRoutes.oneTimePhotoView.name,
                            extra: OneTimeViewNavArguments(
                              imageUrls.first,
                              message.text,
                            ),
                          );

                          // Mark as viewed using your chosen method
                          context
                              .read<ChatWithCubit>()
                              .markTheOneTimeViewImageAsViewed(
                                message,
                              );
                        },
                        oneTimeViewPhotoLabel: oneTimePhotoLabel,
                      )
                    : _buildMessageBubble(message, isMine),
                const SizedBox(width: 8),
                // Time on the right for sender
                Text(
                  DateFormat('h:mm a').format(message.createdAt.toLocal()),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              getFormattedDate(dateTime),
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        );
      },
    );
  }

  StreamMessageInput setupMessageInput(Channel? currentChannel) {
    return StreamMessageInput(
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
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                type: MessageType.regular,
                text: _messageInputController.text,
              );
            }

            /// For Images with no Context
            if (_messageInputController.text.isEmpty &&
                _messageInputController.attachments.isNotEmpty) {
              final selectedImage =
                  _messageInputController.attachments.first.file;
              if (selectedImage != null) {
                framedMessage = Message(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  type: MessageType.regular,
                  attachments: _messageInputController.attachments,
                );
              }
            }

            /// For Images and Text
            if (_messageInputController.text.isNotEmpty &&
                _messageInputController.attachments.isNotEmpty) {
              final selectedImage =
                  _messageInputController.attachments.first.file;
              if (selectedImage != null) {
                framedMessage = Message(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  attachments: _messageInputController.attachments,
                  text: _messageInputController.text,
                );
              }
            }

            if (framedMessage != null) {
              currentChannel?.sendMessage(framedMessage);
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
              GlintAnalyticService.onMediaSelectedEvent();
              final attachmentHandler = StreamAttachmentHandler.instance;
              final result = await attachmentHandler.pickImage(
                source: ImageSource.gallery,
              );
              if (result != null && result.file != null) {
                _messageInputController.addAttachment(Attachment(
                    file: result.file,
                    type: 'image',
                    extraData: const {
                      oneTimeViewKey: true,
                      viewedKey: false,
                    }));
              }
            },
          ),
        ];
      },
      allowedAttachmentPickerTypes: const [
        AttachmentPickerType.images,
      ],
    );
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
        style: AppTheme.simpleBodyText,
      ),
    );
  }

  /// Handle the Image Message for both the users type,
  Widget _chatImageMessageBubble({
    required VoidCallback onImageMessageTap,
    required String oneTimeViewPhotoLabel,
  }) {
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
          GestureDetector(
            onTap: onImageMessageTap,
            child: Text(
              oneTimeViewPhotoLabel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
