import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';

import '../glint_icon_label.dart';

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
    this.isTicketBanner = false,
    this.onDownloadTap,
  });

  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventLocation;
  final String eventInitialPrice;
  final String eventFinalPrice;
  final String dayLeftForEvent;
  final bool? isTicketBanner;
  final VoidCallback? onDownloadTap;

  @override
  Widget build(BuildContext context) {
    final bool isDark = isTicketBanner == true;
    final Color textColor = isDark ? AppColours.white : AppColours.black;

    return Container(
      color: isDark ? AppColours.ticketBackgroundDark : AppColours.backgroundShade,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    eventName,
                    style: AppTheme.headingFour.copyWith(
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0,
                      color: textColor,
                    ),
                  ),
                ),
                if (isDark && onDownloadTap != null)
                  GestureDetector(
                    onTap: onDownloadTap,
                    child: Icon(Icons.download, size: 24.0, color: textColor),
                  ),
                if (!isDark)
                  Container(
                    decoration: BoxDecoration(
                      color: AppColours.black,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    child: Text(
                      '$dayLeftForEvent days left',
                      style: const TextStyle(
                        fontFamily: 'AlbertSans',
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                        color: AppColours.white,
                      ),
                    ),
                  ),
              ],
            ),
            Gap(isDark ? 8.0 : 24.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: GlintIconLabel(
                    iconPath: 'lib/assets/icons/calendar_icon.svg',
                    label: '$eventDate • $eventTime',
                    style: AppTheme.simpleText.copyWith(color: textColor),
                    svgColor: isDark ? AppColours.warning400 : null,
                  ),
                ),
                if (!isDark)
                  Row(
                    children: [
                      Text('₹ ', style: AppTheme.simpleText.copyWith(color: textColor)),
                      Text(
                        eventInitialPrice,
                        style: AppTheme.simpleText.copyWith(
                          color: textColor,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const Gap(6.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: GlintIconLabel(
                    iconPath: 'lib/assets/icons/location_icon.svg',
                    label: eventLocation,
                    style: AppTheme.simpleText.copyWith(color: textColor),
                    svgColor: isDark ? AppColours.warning400 : null,
                  ),
                ),
                if (!isDark)
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '₹ $eventFinalPrice',
                          style: const TextStyle(
                            fontFamily: 'AlbertSans',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: AppColours.primaryBlue,
                          ),
                        ),
                        const TextSpan(
                          text: ' / person',
                          style: TextStyle(
                            fontFamily: 'AlbertSans',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: AppColours.primaryBlue,
                          ),
                        ),
                      ],
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
