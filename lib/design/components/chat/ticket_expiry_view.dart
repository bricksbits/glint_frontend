import 'package:flutter/material.dart';

// Todo: Add the Wave Clipper here
class TicketExpiryView extends StatelessWidget {
  const TicketExpiryView({super.key, required this.expiryDate});

  final String expiryDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(expiryDate),
          const SizedBox(
            height: 10,
          ),
          const Text("This is a Non-Transferrable Ticket"),
          Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
