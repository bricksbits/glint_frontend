import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/chat/chat_ticket_info_view.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ChatTicketInfoView(),
      ),
    );
  }
}
