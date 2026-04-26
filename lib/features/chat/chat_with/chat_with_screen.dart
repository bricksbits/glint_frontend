import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/components/chat/chat_circular_icon_button.dart';
import 'package:glint_frontend/design/components/chat/empty_chat_state_view.dart';
import 'package:glint_frontend/design/components/chat/get_ticket_gradient_view.dart';
import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';
import 'package:glint_frontend/features/chat/chat_with/chat_with_cubit.dart';
import 'package:glint_frontend/features/chat/model/get_ticket_argument_model.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// Reaction config — 5 basic emojis mapped to Stream reaction types.
const _kReactions = [
  ('like', '👍'),
  ('love', '❤️'),
  ('haha', '😂'),
  ('wow', '😮'),
  ('sad', '😢'),
];

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
                                final chatArgs = state.chatNavArgs!;
                                context.pushNamed(
                                  GlintChatRoutes.getTicket.name,
                                  extra: GetTicketArgumentModel(
                                    eventId: chatArgs.eventId ?? "",
                                    matchId: chatArgs.matchId ?? "",
                                    eventName: chatArgs.eventName ?? "",
                                    eventDate: chatArgs.eventStartTime ?? "",
                                    eventTime: chatArgs.eventStartTime ?? "",
                                    eventInitialPrice: "",
                                    eventFinalPrice: "",
                                    dayLeftForEvent: "",
                                    eventLocation: "",
                                    currentUser: UserTicketHolderModel(
                                      userId:
                                          state.currentUserDetails?.id ?? "",
                                      username:
                                          state.currentUserDetails?.name ??
                                              "You",
                                      imageUrl:
                                          state.currentUserDetails?.image ??
                                              "",
                                    ),
                                    matchedUser: UserTicketHolderModel(
                                      userId:
                                          state.oppositeUserDetails?.id ?? "",
                                      username:
                                          state.oppositeUserDetails?.name ??
                                              "Partner",
                                      imageUrl:
                                          state.oppositeUserDetails?.image ??
                                              "",
                                    ),
                                    eventBanner: null,
                                  ),
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
            child: ClipOval(
              child: _HeaderAvatar(imageUrl: oppositeUserImageUrl),
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
            isEventMatch: widget.chatWithNavArguments.eventId != null,
            matchUserId: widget.chatWithNavArguments.matchId ?? "",
            matchUserName: oppositeUserName,
            upgradePlanCallBack: () {
              // Todo: Take the User to the Profile Tab of the Bottom Nav Stack
            },
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
        final bool hasAttachments = attachments.isNotEmpty;
        bool hasBeenViewed = false;
        final imageUrls = attachments.map((file) => file.imageUrl).toList();

        if (hasAttachments) {
          final imageReceived = attachments.first;
          hasBeenViewed = imageReceived.extraData[viewedKey] == true;
        }

        final oneTimePhotoLabel = hasBeenViewed
            ? MediaMessageViewType.Viewed.name
            : MediaMessageViewType.Photo.name;

        // Bubble widget (image or text).
        final bubble = hasAttachments
            ? _chatImageMessageBubble(
                onImageMessageTap: isMine
                    ? () => showCustomSnackbar(
                          context,
                          message: "Once sent, can't be viewed again.",
                        )
                    : () {
                        context.pushNamed(
                          GlintChatRoutes.oneTimePhotoView.name,
                          extra: OneTimeViewNavArguments(
                            imageUrls.first,
                            message.text,
                          ),
                        );
                      },
                oneTimeViewPhotoLabel: oneTimePhotoLabel,
              )
            : GestureDetector(
                onLongPress: () => _showReactionPicker(context, message),
                child: _buildMessageBubble(message, isMine),
              );

        // Reaction counts row (shown below the bubble when reactions exist).
        final reactionCounts = message.reactionCounts ?? {};
        final reactionRow = reactionCounts.isNotEmpty
            ? _buildReactionRow(context, message, isMine)
            : const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
                isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (isMine) ...[
                Text(
                  DateFormat('h:mm a').format(message.createdAt.toLocal()),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [bubble, reactionRow],
                ),
              ] else ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [bubble, reactionRow],
                ),
                const SizedBox(width: 8),
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

  // ------------------- Reaction Picker ----------------------------

  void _showReactionPicker(BuildContext context, Message message) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black26,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _kReactions.map((pair) {
                final type = pair.$1;
                final emoji = pair.$2;
                final hasReacted =
                    message.ownReactions?.any((r) => r.type == type) ??
                        false;
                return InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    context
                        .read<ChatWithCubit>()
                        .toggleReaction(message, type);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      emoji,
                      style: TextStyle(
                        fontSize: 26,
                        // Highlight if the user already picked this one.
                        shadows: hasReacted
                            ? [
                                const Shadow(
                                  color: AppColours.primaryBlue,
                                  blurRadius: 12,
                                )
                              ]
                            : null,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReactionRow(
      BuildContext context, Message message, bool isMine) {
    final counts = message.reactionCounts ?? {};
    final ownTypes = {
      for (final r in message.ownReactions ?? []) r.type,
    };

    final chips = counts.entries
        .where((e) => e.value > 0)
        .map((e) {
          final emoji = _kReactions
              .firstWhere(
                (r) => r.$1 == e.key,
                orElse: () => (e.key, ''),
              )
              .$2;
          if (emoji.isEmpty) return const SizedBox.shrink();
          final mine = ownTypes.contains(e.key);
          return GestureDetector(
            onTap: () => context
                .read<ChatWithCubit>()
                .toggleReaction(message, e.key),
            child: Container(
              margin: const EdgeInsets.only(top: 4, right: 4),
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: mine
                    ? AppColours.backgroundShade
                    : AppColours.lightGray,
                borderRadius: BorderRadius.circular(12),
                border: mine
                    ? Border.all(color: AppColours.primaryBlue, width: 1)
                    : null,
              ),
              child: Text(
                '$emoji ${e.value}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        })
        .toList();

    if (chips.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Wrap(children: chips),
    );
  }

  // ------------------- Message Input ----------------------------

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
        style: AppTheme.simpleBodyText.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

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
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: const Icon(Icons.image_outlined,
                color: Colors.white, size: 24),
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

// ---------------------------------------------------------------------------
// Private header avatar — handles empty/null URL gracefully.
// ---------------------------------------------------------------------------
class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: 32,
        height: 32,
        color: AppColours.mediumGray,
        child: const Icon(Icons.person, size: 18, color: AppColours.darkGray),
      );
    }
    return FadeInImage.assetNetwork(
      placeholder: 'lib/assets/images/new_default_profile_place_holder.jpg',
      image: imageUrl,
      width: 32,
      height: 32,
      fit: BoxFit.cover,
      imageErrorBuilder: (_, __, ___) => Image.asset(
        'lib/assets/images/new_default_profile_place_holder.jpg',
        width: 32,
        height: 32,
        fit: BoxFit.cover,
      ),
    );
  }
}
