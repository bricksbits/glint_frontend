import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget chatCircularIconButton({
  required String svgAssetPath,
  required VoidCallback onPressed,
  double radius = 20.0, // Radius of the CircleAvatar
  Color? backgroundColor,
  Color? iconColor,
  EdgeInsetsGeometry? padding,
}) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(radius), // For InkWell ripple
      child: CircleAvatar(
        radius: radius,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(6),
          child: SvgPicture.asset(
            svgAssetPath,
            width: radius, // Adjust as needed
            height: radius,
          ),
        ),
      ),
    ),
  );
}
