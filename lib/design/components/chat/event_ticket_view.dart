import 'dart:ui' as ui;

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/chat/common_ticket_banner.dart';
import 'package:glint_frontend/design/components/chat/ticket_code_view.dart';
import 'package:glint_frontend/design/components/chat/ticket_holders_view.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ticket_details_component.dart';

class EventTicketView extends StatelessWidget {
  const EventTicketView({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    required this.couponCode,
    required this.expiryDate,
    required this.person1,
    required this.person2,
    required this.totalAmount,
    required this.googleMapsUrl,
    required this.latitude,
    required this.longitude,
    required this.bannerImageUrl,
    required this.onInfoClicked,
    required this.onClosedClicked,
    this.onDownloadTap,
  });

  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventLocation;
  final String couponCode;
  final String expiryDate;
  final UserTicketHolderModel person1;
  final UserTicketHolderModel person2;
  final String totalAmount;
  final String googleMapsUrl;
  final double latitude;
  final double longitude;
  final String bannerImageUrl;
  final VoidCallback onInfoClicked;
  final VoidCallback onClosedClicked;
  final VoidCallback? onDownloadTap;

  Future<void> _openMaps() async {
    final uri = Uri.parse(googleMapsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ClipPath(
        clipper: _TicketWaveClipper() as CustomClipper<ui.Path>,
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
                bannerImagerUrl: bannerImageUrl,
                onInfoClicked: onInfoClicked,
                onClosedClicked: onClosedClicked,
              ),
              TicketDetailsComponent(
                eventName: eventName,
                eventDate: eventDate,
                eventTime: eventTime,
                eventLocation: eventLocation,
                eventInitialPrice: '',
                eventFinalPrice: '',
                dayLeftForEvent: '',
                isTicketBanner: true,
                onDownloadTap: onDownloadTap,
              ),
              const Gap(8.0),
              _MapPreview(
                latitude: latitude,
                longitude: longitude,
                onTap: _openMaps,
              ),
              const Gap(16.0),
              TicketHolderView(
                person1: person1,
                person2: person2,
                totalAmount: totalAmount,
              ),
              const Gap(24.0),
              _TearOffDivider(),
              TicketCodeView(
                couponCode: couponCode,
                expiryDate: expiryDate,
              ),
              const Gap(48.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapPreview extends StatelessWidget {
  const _MapPreview({
    required this.latitude,
    required this.longitude,
    required this.onTap,
  });

  final double latitude;
  final double longitude;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            height: 90,
            width: double.infinity,
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(latitude, longitude),
                    initialZoom: 15.0,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.none,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.glint.glint_frontend',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(latitude, longitude),
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
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
        ),
      ),
    );
  }
}

class _TearOffDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class _TicketWaveClipper extends CustomClipper<ui.Path> {
  @override
  ui.Path getClip(Size size) {
    final path = ui.Path();
    path.lineTo(0, size.height - 12);

    final double segmentWidth = size.width / 6.5;
    const double waveHeight = 12.0;

    for (double x = 0; x < size.width; x += segmentWidth) {
      path.quadraticBezierTo(
        x + segmentWidth / 4,
        size.height,
        x + segmentWidth / 2,
        size.height - waveHeight,
      );
      path.quadraticBezierTo(
        x + 3 * segmentWidth / 4,
        size.height - 2 * waveHeight,
        x + segmentWidth,
        size.height - waveHeight,
      );
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<ui.Path> oldClipper) => false;
}
