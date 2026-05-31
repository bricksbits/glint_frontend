import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';

const String chatWithEventId = "event_id";
const String chatWithEventName = "event_name";
const String chatWithEventStartTime = "event_start_time";
const String chatWithMatchId = "matched_via";

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

  /// Connects using a token-provider callback so Stream can automatically
  /// request a fresh JWT whenever the current one expires — no manual
  /// reconnect loop needed on the app side.
  ///
  /// [tokenProvider] matches Stream's internal `TokenProvider` typedef:
  /// `Future<String> Function(String userId)`.
  Future<void> connectUserWithProvider({
    required String userId,
    required String userName,
    required String profileImageUrl,
    required Future<String> Function(String userId) tokenProvider,
  }) async {
    if (isConnected && client.state.currentUser?.id == userId) {
      return;
    }

    client.chatPersistenceClient = persistenceClient;
    await persistenceClient.connect(userId);

    await client.connectUserWithProvider(
      User(
        id: userId,
        name: userName,
        image: profileImageUrl,
      ),
      tokenProvider,
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
