import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/services/chat_service.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

part 'chat_with_state.dart';

part 'chat_with_cubit.freezed.dart';

class ChatWithCubit extends Cubit<ChatWithState> {
  final ChatService chatService = getIt.get<ChatService>();
  final String logPrefix = "ChatWithCubit";

  ChatWithCubit() : super(const ChatWithState.initial());

  Future<void> connectToChannel(ChatWithNavArguments navArguments) async {
    chatService.setupChannelWithNavArgs(navArguments).then((connectedChannel) {
      emit(state.copyWith(
        isLoading: false,
        chatAvailable: true,
        currentChannel: connectedChannel,
        chatNavArgs: navArguments,
      ));
      setupOppositeUserData();
    }, onError: (error) {
      emit(state.copyWith(
          isLoading: false,
          chatAvailable: false,
          currentChannel: null,
          error: "Chat Unavailable, Servers went out"));
    });
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

  void closeChannel() {
    state.currentChannel?.dispose();
  }
}
