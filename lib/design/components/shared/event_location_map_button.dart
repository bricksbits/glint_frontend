import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class EventLocationMapButton extends StatelessWidget {
  const EventLocationMapButton({
    super.key,
    required this.latitude,
    required this.longitude,
    this.googleMapsUrl,
    this.height = 150.0,
    this.horizontalPadding = 0.0,
    this.borderRadius = 12.0,
  });

  final double latitude;
  final double longitude;

  /// Optional explicit Google Maps URL. When null, a URL is constructed from
  /// [latitude] and [longitude].
  final String? googleMapsUrl;

  final double height;
  final double horizontalPadding;
  final double borderRadius;

  Future<void> _openMaps() async {
    final url = googleMapsUrl != null && googleMapsUrl!.isNotEmpty
        ? googleMapsUrl!
        : "https://maps.google.com/maps?q=$latitude,$longitude";
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: GestureDetector(
        onTap: _openMaps,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: SizedBox(
            height: height,
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
