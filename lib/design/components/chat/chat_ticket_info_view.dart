import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
          side: const BorderSide(color: Colors.white70, width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Event Image
            CommonTicketBanner(
              bannerImagerUrl:
                  'lib/assets/images/chat/chat_ticket_info_pace_holder.png',
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
              dayLeftForEvent: "21",
            ),
            // Divider
            // Payment Options
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.purple.shade100,
                child: const Icon(
                  Icons.movie,
                  color: Colors.purple,
                  size: 30.0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                'Choose your ticket payment option',
                style: TextStyle(
                    fontSize: 16.0,
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
                      top: 14.0,
                      right: 50.0,
                      bottom: 14.0,
                      left: 50.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.payment, color: Colors.white),
                        Gap(12.0),
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
            const Gap(16.0),
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
                      top: 14.0,
                      right: 50.0,
                      bottom: 14.0,
                      left: 50.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.group, color: Colors.white),
                        Gap(12.0),
                        Text(
                          'Split Payment',
                          style: TextStyle(
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
            const Gap(48.0),
            const Padding(
              padding: EdgeInsets.only(bottom: 24.0),
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
