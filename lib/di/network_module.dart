import 'package:dio/dio.dart';
import 'package:glint_frontend/data/remote/client/glint_api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio getHttpClientInstance() => Dio(
        BaseOptions(
          baseUrl: GlintApiConstants.glintBaseUrl,
          connectTimeout:
              const Duration(milliseconds: GlintApiConstants.apiTimeOut),
          receiveTimeout:
              const Duration(milliseconds: GlintApiConstants.apiReceiveTimeOut),
        ),
      );

  @singleton
  StreamChatClient chatClient() => StreamChatClient(STREAM_API_KEY);
}

const STREAM_API_KEY = '8w29vcuv56ny';
