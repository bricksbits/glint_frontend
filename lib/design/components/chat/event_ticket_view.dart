import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/chat/common_ticket_banner.dart';
import 'package:glint_frontend/design/components/chat/ticket_code_view.dart';
import 'package:glint_frontend/design/components/chat/ticket_expiry_view.dart';
import 'package:glint_frontend/design/components/chat/ticket_holders_view.dart';

import 'ticket_details_component.dart';

//Todo: Remove the Scaffold once Attached to the Chat Screen.
//Todo: Insert the Map View as well instead of Container
class EventTicketView extends StatelessWidget {
  const EventTicketView(
      {super.key, required this.eventName, required this.onDowloadTicket});

  final String eventName;
  final VoidCallback onDowloadTicket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonTicketBanner(
                bannerImagerUrl: "",
                onInfoClicked: () {},
                onClosedClicked: () {},
              ),
              const TicketDetailsComponent(
                eventName: "Long Event name",
                eventDate: "30st Dec 2024",
                eventTime: "9:00 PM",
                eventLocation: "Near Raipur Chai Stall",
                eventInitialPrice: "400",
                eventFinalPrice: "200",
                dayLeftForEvent: "21 days left",
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.pink,
                  height: 66,
                  width: double.infinity,
                ),
              ),
              const TicketHolderView(
                person1Name: "Person1",
                person2Name: "Person2",
                totalAmount: "420",
              ),
              const TicketCodeView(couponCode: "BHSP23JN"),
              const TicketExpiryView(expiryDate: "1st January")
            ],
          ),
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Or your desired color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    const double dashLength = 10;
    const double dashSpace = 5;

    double startX = 0;
    while (startX < size.width) {
      path.moveTo(startX, size.height / 2); // Center the line vertically
      path.lineTo(startX + dashLength, size.height / 2);
      startX += dashLength + dashSpace;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
