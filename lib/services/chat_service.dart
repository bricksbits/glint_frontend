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
  final String pushProviderName;

  ChatService({
    required this.client,
    required this.persistenceClient,
    required this.pushProviderName,
  });

  /// Call this after your auth flow gives you the user data + Stream token.
  /// Works identically for login and fresh account creation.
  /// Safe to call on every cold start — skips reconnection if the same user
  /// is already connected.
  Future<void> connectUser({
    required String userId,
    required String userName,
    required String userToken,
    required String profileImageUrl,
  }) async {
    // Guard: skip if already connected as this user to avoid StreamChatError.
    if (isConnected && client.state.currentUser?.id == userId) {
      return;
    }

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

  /// Registers the device for push notifications via Stream + FCM.
  /// Pass [cachedToken] (from SharedPreferences) for an immediate registration
  /// before Firebase returns a fresh token; both paths are tried.
  Future<void> registerDevice({String? cachedToken}) async {
    if (cachedToken != null && cachedToken.isNotEmpty) {
      await client.addDevice(cachedToken, PushProvider.firebase, pushProviderName: pushProviderName);
    }

    final freshToken = await FirebaseMessaging.instance.getToken();
    if (freshToken != null && freshToken != cachedToken) {
      await client.addDevice(freshToken, PushProvider.firebase, pushProviderName: pushProviderName);
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      client.addDevice(newToken, PushProvider.firebase, pushProviderName: pushProviderName);
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
