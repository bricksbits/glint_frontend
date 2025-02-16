import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class TicketDetailsComponent extends StatelessWidget {
  const TicketDetailsComponent({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    required this.eventInitialPrice,
    required this.eventFinalPrice,
    required this.dayLeftForEvent,
  });

  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventLocation;
  final String eventInitialPrice;
  final String eventFinalPrice;
  final String dayLeftForEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColours.backgroundShade,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  eventName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cambon',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4), // Adjust padding
                  decoration: BoxDecoration(
                    color: AppColours.black, // Background color
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                  child: Text(
                    dayLeftForEvent,
                    style: const TextStyle(
                        fontFamily: 'AlbertSans',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColours.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 18,
                    ),
                    Text(
                      "$eventDate - $eventTime",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Cambon',
                      ),
                    ),
                  ],
                ),
                Text(
                  eventInitialPrice,
                  style: const TextStyle(
                    fontFamily: "AlbertSans",
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 18,
                    ),
                    Text(
                      eventLocation,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Cambon',
                      ),
                    ),
                  ],
                ),
                Text(
                  "$eventFinalPrice/person",
                  style: const TextStyle(
                    fontFamily: "AlbertSans",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColours.purpleShade,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
