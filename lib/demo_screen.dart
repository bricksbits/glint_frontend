import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/chat/empty_chat_state_view.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EmptyChatStateView(
          isEventMatch: false,
          matchUserId: '1',
          matchUserName: 'Shubheksha',
          upgradePlanCallBack: () {},
        ),
      ),
    );
  }
}
