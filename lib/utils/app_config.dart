import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late String baseUrl;
  static late String streamApiKey;
  static late String envType;
  static late String streamPushProviderName;

  /// Options
  /// prod : For Productions
  /// staging : For Staging
  static Future<void> initialize() async {
    const String env = String.fromEnvironment('ENVIRONMENT', defaultValue: 'staging');
    await dotenv.load(fileName: ".env.$env");

    baseUrl = dotenv.get('API_BASE_URL');
    streamApiKey = dotenv.get('STREAM_API_KEY');
    envType = dotenv.get('ENVIRONMENT_NAME');
    streamPushProviderName = dotenv.get('STREAM_PUSH_PROVIDER_NAME');
  }
}