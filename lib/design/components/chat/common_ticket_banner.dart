import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint_frontend/design/exports.dart';

//Todo: Change the Network Image URL
//Todo: Add Error Builders
class CommonTicketBanner extends StatelessWidget {
  const CommonTicketBanner(
      {super.key,
      required this.bannerImagerUrl,
      required this.onInfoClicked,
      required this.onClosedClicked});

  final String bannerImagerUrl;
  final VoidCallback onInfoClicked;
  final VoidCallback onClosedClicked;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Stack(
        children: [
          Container(
            height: 108,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  bannerImagerUrl,
                ),
                // Replace with event image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'lib/assets/icons/info_icon.svg',
                ),
                onPressed: () {
                  // todo - add event info popup
                },
              ),
              IconButton(
                icon: const CircleAvatar(
                  radius: 10.0,
                  backgroundColor: AppColours.white,
                  child: Icon(
                    Icons.close,
                    size: 14.0,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  // todo - close ticket popup
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
