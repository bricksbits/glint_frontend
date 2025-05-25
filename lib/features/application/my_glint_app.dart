import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/navigation/glint_admin_route_config.dart';
import 'package:glint_frontend/navigation/glint_main_route_config.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';

class MyGlintApp extends StatelessWidget {
  MyGlintApp({super.key});

  final StreamChatClient chatClient = getIt.get<StreamChatClient>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Glint People App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      // routerConfig: kIsWeb ? glintAdminRoutes : glintMainRoutes,
      routerConfig: glintMainRoutes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalStreamChatLocalizations.delegate
        // Add this for Cupertino widgets if needed
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      builder: (context, child) {
        return StreamChat(
          streamChatThemeData: StreamChatThemeData(),
          client: chatClient,
          child: child,
        );
      },
    );
  }
}
