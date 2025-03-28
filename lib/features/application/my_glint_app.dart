import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/exports.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MyGlintApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;

  const MyGlintApp({super.key, required this.client, required this.channel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Glint People App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      // home: StreamChannel(
      //   channel: channel,
      //   child: const ChatScreen(),
      // ),
      // builder: (context, widget) {
      //   return StreamChat(
      //     client: client,
      //     child: widget,
      //   );
      // },
      home: const Scaffold(
        body: HomeScreen(),
      ),
      // routerConfig: glintMainRoutes,
    );
  }
}
