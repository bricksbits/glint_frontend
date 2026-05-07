import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/services/chat_service.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
    hide Member;
import 'package:stream_chat_flutter/stream_chat_flutter.dart'
    show Reaction, Member;

part 'chat_with_state.dart';

part 'chat_with_cubit.freezed.dart';

class ChatWithCubit extends Cubit<ChatWithState> {
  final ChatService chatService = getIt.get<ChatService>();
  final String logPrefix = "ChatWithCubit";

  ChatWithCubit() : super(const ChatWithState.initial());

  Future<void> connectToChannel(ChatWithNavArguments navArguments) async {
    try {
      final channel = chatService.getChannel(navArguments.channelId);
      await channel.watch();

      final extraData = channel.extraData;

      // Channel extraData (written by the backend) is the primary source;
      // nav args are the fallback for older channels or propagation delays.
      // event_start_time is not yet sent by the backend — use nav args only.
      final effectiveEventId =
          extraData[chatWithEventId] as String? ?? navArguments.eventId;
      final effectiveEventName =
          extraData[chatWithEventName] as String? ?? navArguments.eventName;
      final effectiveMatchId =
          extraData[chatWithMatchId] as String? ?? navArguments.matchId;

      emit(state.copyWith(
        isLoading: false,
        chatAvailable: true,
        currentChannel: channel,
        chatNavArgs: ChatWithNavArguments(
          channelId: navArguments.channelId,
          eventId: effectiveEventId,
          eventName: effectiveEventName,
          eventStartTime: navArguments.eventStartTime,
          matchId: effectiveMatchId,
        ),
      ));
      setupOppositeUserData();
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        chatAvailable: false,
        currentChannel: null,
        error: "Chat Unavailable, Servers went out",
      ));
    }
  }

  void setupOppositeUserData() {
    final currentUser = chatService.getCurrentUser();
    if (currentUser != null) {
      final oppositeMember = state.currentChannel?.state?.members.firstWhere(
        (member) => member.userId != currentUser.id,
        orElse: () => Member(),
      );
      emit(state.copyWith(
        currentUserDetails: currentUser,
        oppositeUserDetails: oppositeMember?.user,
      ));
    }
  }

  Future<void> markTheOneTimeViewImageAsViewed(
    Message? messageWithMedia,
  ) async {
    try {
      if (messageWithMedia == null) {
        debugLogger(logPrefix, "Message is null");
        return;
      }

      if (messageWithMedia.attachments.isEmpty) {
        debugLogger(logPrefix, "⚠️ Message has no attachments to update.");
        return;
      }

      final attachment = messageWithMedia.attachments.first;

      final updatedExtraData = Map<String, Object?>.from(attachment.extraData);
      updatedExtraData[viewedKey] = true;

      final updatedAttachment =
          attachment.copyWith(extraData: updatedExtraData);

      final updatedMessage =
          messageWithMedia.copyWith(attachments: [updatedAttachment]);

      await chatService.client.updateMessage(updatedMessage);

      debugLogger(
          logPrefix, "${messageWithMedia.id} updated with viewed property");
    } catch (e, st) {
      debugLogger(
          logPrefix, "${messageWithMedia?.id} update failed with, Error : $e");
    }
  }

  /// Toggles a reaction on a message. Sends the reaction if the current user
  /// hasn't reacted with [reactionType] yet; removes it if they have.
  Future<void> toggleReaction(Message message, String reactionType) async {
    final channel = state.currentChannel;
    if (channel == null) return;

    final hasReacted =
        message.ownReactions?.any((r) => r.type == reactionType) ?? false;

    try {
      if (hasReacted) {
        await channel.deleteReaction(message, Reaction(type: reactionType));
      } else {
        await channel.sendReaction(message, reactionType);
      }
    } catch (e) {
      debugLogger(logPrefix, "toggleReaction failed: $e");
    }
  }

  void onUpgradePlanTapped() {
    emit(state.copyWith(navigateToProfile: true));
  }

  void clearNavigateToProfile() {
    emit(state.copyWith(navigateToProfile: false));
  }

  void closeChannel() {
    state.currentChannel?.dispose();
  }
}
