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
    const interactedUsers = [
      'https://avatars.githubusercontent.com/u/70279771?v=4',
      'https://avatars.githubusercontent.com/u/70279771?v=4',
      'https://avatars.githubusercontent.com/u/70279771?v=4',
    ];
    const eventDescription =
        """Get ready to experience the most delicius and diverse flavors at the Local Food Fest! This is the ultimate event for food lovers in Raipur!\n
Join us on 4th Jan at Shriram Business Park to enjoy mouth-watering street foods, regional spacialities, and exotic dishes from across India. From spicy chaats to sweet jalebis, there's something for every foodie's taste buds.

With live music, fun activites, and cooking workshops, this fest promises a memorable day for families, friends, and food enthusiasts. Don't miss out on the chance to discover new favourites and meet local food heros.

Mark your calender, bring your appetite, and let’s make this fest a celebration to remember!""";

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

            Gap(32.0),

            // interested profiles
            _BuildInterestedProfiles(
              interestedProfiles: interactedUsers,
            ),

            Gap(32.0),

            // about event
            _AboutEvent(
              eventDescription: eventDescription,
            ),

            // end of the page gap for design replication purpose
            Gap(20.0),
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

class _BuildInterestedProfiles extends StatelessWidget {
  const _BuildInterestedProfiles({
    super.key,
    required this.interestedProfiles,
  });

  final List<String> interestedProfiles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: const BoxDecoration(
        color: AppColours.black,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...interestedProfiles.map(
            (userImage) => Align(
              widthFactor: 0.5,
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: CircleAvatar(
                  radius: 10.0,
                  backgroundImage: NetworkImage(userImage),
                ),
              ),
            ),
          ),
          const Gap(20.0),
          Text(
            'See interested profiles',
            style: AppTheme.simpleText.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColours.white,
            ),
          ),
          const Gap(2.0),
          const Icon(
            Icons.chevron_right,
            color: AppColours.warning300,
          ),
        ],
      ),
    );
  }
}

class _AboutEvent extends StatelessWidget {
  const _AboutEvent({
    super.key,
    required this.eventDescription,
  });

  final String eventDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Event',
            style: AppTheme.simpleBodyText.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(6.0),
          Text(
            eventDescription,
            style: AppTheme.simpleText,
          ),
        ],
      ),
    );
  }
}
