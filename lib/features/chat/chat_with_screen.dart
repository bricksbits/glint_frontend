import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatWithScreen extends StatelessWidget {
  const ChatWithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: StreamChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput(),
        ],
      ),
    );
  }
}
