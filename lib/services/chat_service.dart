import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';

const String chatWithEventId = "CHAT_WITH_EVENT_ID";
const String chatWithEventName = "CHAT_WITH_EVENT_NAME";
const String chatWithEventStartTime = "CHAT_WITH_EVENT_START_TIME";

class ChatService {
  final StreamChatClient client;
  final StreamChatPersistenceClient persistenceClient;

  ChatService({
    required this.client,
    required this.persistenceClient,
  });

  /// Call this after your auth flow gives you the user data + Stream token.
  /// Works identically for login and fresh account creation.
  Future<void> connectUser({
    required String userId,
    required String userName,
    required String userToken,
    required String profileImageUrl,
  }) async {
    client.chatPersistenceClient = persistenceClient;
    await persistenceClient.connect(userId);

    await client.connectUser(
      User(
        id: userId,
        name: userName,
        image: profileImageUrl,
      ),
      userToken,
    );
  }

  //Todo: Research is needed to make it work
  // Delegate to Phase 2
  Future<void> _registerFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await client.addDevice(token, PushProvider.firebase);
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      client.addDevice(newToken, PushProvider.firebase);
    });
  }

  /// Opens a messaging channel by its ID (provided from your backend).
  /// Creates it if it doesn't already exist.
  Channel getChannel(String channelId) {
    return client.channel(
      'messaging',
      id: channelId,
    );
  }

  Future<Channel> setupChannelWithNavArgs(ChatWithNavArguments args) async {
    final currentChannel = client.channel(
      'messaging',
      id: args.channelId,
      extraData: {
        chatWithEventId: args.eventId,
        chatWithEventName: args.eventName,
        chatWithEventStartTime: args.eventStartTime,
      },
    );
    currentChannel.watch();
    return currentChannel;
  }

  /// Watch a channel — this subscribes to live updates (messages, reads, etc.)
  Future<Channel> watchChannel(String channelId) async {
    final channel = getChannel(channelId);
    await channel.watch();
    return channel;
  }

  Future<void> disconnectUser() async {
    await client.disconnectUser(
      flushChatPersistence: false,
    );
    await persistenceClient.disconnect();
  }

  Future<void> sendMessageToChannel({
    required String channelId,
    required String text,
    required bool isStoryReply,
  }) async {
    final channel = client.channel('messaging', id: channelId);
    await channel.create();
    final message = Message(
      text: isStoryReply ? "Replied to your story: $text" : text,
    );
    await channel.sendMessage(message);
  }

  bool get isConnected =>
      client.wsConnectionStatus == ConnectionStatus.connected;

  User? getCurrentUser() => client.state.currentUser;
}
