import 'package:flutter/material.dart';

class TicketCodeView extends StatelessWidget {
  const TicketCodeView({super.key, required this.couponCode});

  final String couponCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(couponCode),
          const SizedBox(
            height: 20,
          ),
          const Text("Tickets will be verified at the event through Glint App"),
          Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
