import 'package:flutter/material.dart';

class ProfileNameAndDetailColumn extends StatelessWidget {
  final String name;
  final String age;
  final bool isPremiumUser;
  final String distance;
  final String views;

  const ProfileNameAndDetailColumn(
      {super.key,
      required this.name,
      required this.distance,
      required this.views, required this.age, required this.isPremiumUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$name, $age',
          style: const TextStyle(fontFamily: 'Cambon', fontSize: 28),
        ),
        Text(
          '$distance KM away',
          style: const TextStyle(fontFamily: 'Cambon', fontSize: 14),
        ),
        Text(
          '$views views',
          style: const TextStyle(fontFamily: 'Cambon', fontSize: 14),
        ),
      ],
    );
  }
}
