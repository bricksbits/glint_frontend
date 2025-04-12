import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/chat/common_ticket_banner.dart';
import 'package:glint_frontend/design/components/chat/ticket_code_view.dart';
import 'package:glint_frontend/design/components/chat/ticket_holders_view.dart';
import 'package:glint_frontend/design/exports.dart';

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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ClipPath(
        clipper: MultipleWaveClipper(),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColours.ticketBackgroundDark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTicketBanner(
                bannerImagerUrl:
                    'lib/assets/images/chat/chat_ticket_info_pace_holder.png',
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
                dayLeftForEvent: "21",
                isTicketBanner: true,
              ),
              const Gap(8.0),
              // map
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Stack(
                  children: [
                    Container(
                      height: 66,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColours.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Image.asset(
                        'lib/assets/icons/export-arrow.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(16.0),
              const TicketHolderView(
                person1Name: "Person1",
                person2Name: "Person2",
                totalAmount: "420",
              ),

              const Gap(24.0),

              // ui

              Row(
                children: [
                  Transform.translate(
                    offset: const Offset(-17.0, 0.0),
                    child: Container(
                      height: 34.0,
                      width: 34.0,
                      decoration: const BoxDecoration(
                        color: AppColours.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: DottedLine(
                      dashColor: AppColours.white,
                      dashGapLength: 8.0,
                      dashGapRadius: 12.0,
                      dashLength: 12.0,
                      dashRadius: 12.0,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(17.0, 0.0),
                    child: Container(
                      height: 34.0,
                      width: 34.0,
                      decoration: const BoxDecoration(
                        color: AppColours.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              // ticket
              const TicketCodeView(
                couponCode: "BHSP23JN",
                expiryDate: '1 January 2025',
              ),

              const Gap(48.0),
            ],
          ),
        ),
      ),
    );
  }
}

// Multiple waves clipper
class MultipleWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 12);

    double waveWidth = size.width / 6.5;
    double waveHeight = 12.0;

    for (double x = 0; x < size.width; x += waveWidth) {
      path.quadraticBezierTo(
        x + waveWidth / 4,
        size.height,
        x + waveWidth / 2,
        size.height - waveHeight,
      );
      path.quadraticBezierTo(
        x + 3 * waveWidth / 4,
        size.height - 2 * waveHeight,
        x + waveWidth,
        size.height - waveHeight,
      );
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
