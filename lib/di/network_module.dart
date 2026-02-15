import 'package:dio/dio.dart';
import 'package:glint_frontend/data/remote/client/glint_api_constants.dart';
import 'package:glint_frontend/services/chat_service.dart';
import 'package:glint_frontend/utils/app_config.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio getHttpClientInstance() => Dio(
        BaseOptions(
          baseUrl: AppConfig.baseUrl,
          connectTimeout:
              const Duration(milliseconds: GlintApiConstants.apiTimeOut),
          receiveTimeout:
              const Duration(milliseconds: GlintApiConstants.apiReceiveTimeOut),
        ),
      );

  @singleton
  StreamChatClient chatClient() =>
      StreamChatClient(AppConfig.streamApiKey, logLevel: Level.ALL);

  @singleton
  StreamChatPersistenceClient providePersistenceChatClient() =>
      StreamChatPersistenceClient();

  @singleton
  ChatService provideChatService(
    StreamChatClient client,
    StreamChatPersistenceClient persistenceClient,
  ) =>
      ChatService(
        client: client,
        persistenceClient: persistenceClient,
      );
}
