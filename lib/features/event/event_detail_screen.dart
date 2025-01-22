import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const eventName = 'Taste Dubs';
    const eventDate = '20 May 2023';
    const eventTime = '12:00 PM';
    const oldPrice = 349;
    const newPrice = 199;
    const daysLeft = 7;
    const eventLocation = 'New Delhi, India';
    const imageUrl =
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cmVzdGF1cmFudHxlbnwwfHwwfHx8MA%3D%3D';

    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColours.white,
        title: Text(
          'Event',
          style: AppTheme.headingTwo.copyWith(fontSize: 20.0),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // event image
            _EventImage(imageUrl: imageUrl),

            // event Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(40.0),
                  _EventTitle(title: eventName),
                  Gap(20.0),
                  _EventDetails(
                    date: eventDate,
                    time: eventTime,
                    location: eventLocation,
                  ),
                  Gap(24.0),
                  _EventPricing(
                    oldPrice: oldPrice,
                    newPrice: newPrice,
                    daysLeft: daysLeft,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventImage extends StatelessWidget {
  final String imageUrl;

  const _EventImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280.0,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _EventTitle extends StatelessWidget {
  final String title;

  const _EventTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTheme.headingTwo.copyWith(
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}

class _EventDetails extends StatelessWidget {
  final String date;
  final String time;
  final String location;

  const _EventDetails({
    required this.date,
    required this.time,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlintIconLabel(
          iconPath: 'lib/assets/icons/calendar_icon.svg',
          label: '$date - $time',
          style: AppTheme.simpleText,
        ),
        const Gap(8.0),
        GlintIconLabel(
          iconPath: 'lib/assets/icons/location_icon.svg',
          label: location,
          style: AppTheme.simpleText,
        ),
      ],
    );
  }
}

class _EventPricing extends StatelessWidget {
  final int oldPrice;
  final int newPrice;
  final int daysLeft;

  const _EventPricing({
    required this.oldPrice,
    required this.newPrice,
    required this.daysLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('₹ ', style: AppTheme.simpleText),
            Text(
              oldPrice.toString(),
              style: AppTheme.simpleText.copyWith(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '₹ $newPrice',
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
                      fontWeight: FontWeight.w400,
                      color: AppColours.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8.0),
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
                '$daysLeft days left',
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
      ],
    );
  }
}
