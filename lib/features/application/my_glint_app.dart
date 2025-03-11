import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/event/event_ticket_history_screen.dart';
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
      home: const EventTicketHistoryScreen(),
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
      // home: Scaffold(
      //   body: Center(
      //     child: EventTicketView(
      //       eventName: 'This is a Event Name',
      //       onDowloadTicket: () {},
      //     ),
      //   ),
      // ),
      // routerConfig: glintMainRoutes,
    );
  }
}
