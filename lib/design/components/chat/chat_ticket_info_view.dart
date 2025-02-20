import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/chat/common_ticket_banner.dart';
import 'package:glint_frontend/design/components/chat/ticket_details_component.dart';

class ChatTicketInfoView extends StatelessWidget {
  const ChatTicketInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Event Image
            CommonTicketBanner(
              bannerImagerUrl: "",
              onInfoClicked: () {},
              onClosedClicked: () {},
            ),
            // Event Details
            const TicketDetailsComponent(
              eventName: "Long Event name",
              eventDate: "30st Dec 2024",
              eventTime: "9:00 PM",
              eventLocation: "Near Raipur Chai Stall",
              eventInitialPrice: "400",
              eventFinalPrice: "200",
              dayLeftForEvent: "21 days left",
            ),
            // Divider
            // Payment Options
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.purple.shade100,
                child: const Icon(Icons.movie, color: Colors.purple, size: 30),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'Choose your ticket payment option',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "AlbertSans"),
              ),
            ),
            // Payment Buttons
            IntrinsicWidth(
              child: IntrinsicHeight(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 14, right: 50, bottom: 14, left: 50),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.payment, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Pay for Both',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cambon',
                              color: AppColours.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            IntrinsicWidth(
              child: IntrinsicHeight(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 14, right: 50, bottom: 14, left: 50),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.group, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Split Payment',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cambon',
                              color: AppColours.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text(
                'Note: Tickets will be sent to the person who makes the payment.',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
