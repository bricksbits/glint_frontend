import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class GetTicketGradientView extends StatelessWidget {
  final String eventName;
  final String eventId;
  final String eventDate;
  final String eventOffers;
  final VoidCallback onGetTicketClicked;

  const GetTicketGradientView(
      {super.key,
      required this.eventName,
      required this.eventId,
      required this.eventDate,
      required this.eventOffers,
      required this.onGetTicketClicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onGetTicketClicked,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColours.purpleShade, AppColours.black],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$eventName",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$eventDate • $eventOffers",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              "Get Tickets",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}
