import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint_frontend/design/exports.dart';

class CommonTicketBanner extends StatelessWidget {
  const CommonTicketBanner({
    super.key,
    required this.bannerImagerUrl,
    required this.onInfoClicked,
    required this.onClosedClicked,
  });

  final String bannerImagerUrl;
  final VoidCallback onInfoClicked;
  final VoidCallback onClosedClicked;

  bool get _isNetworkImage =>
      bannerImagerUrl.startsWith('http://') ||
      bannerImagerUrl.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Stack(
        children: [
          SizedBox(
            height: 108,
            width: double.infinity,
            child: _isNetworkImage
                ? CachedNetworkImage(
                    imageUrl: bannerImagerUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: AppColours.borderGray,
                    ),
                    errorWidget: (_, __, ___) => Image.asset(
                      'lib/assets/images/chat/chat_ticket_info_pace_holder.png',
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    bannerImagerUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: SvgPicture.asset('lib/assets/icons/info_icon.svg'),
                onPressed: onInfoClicked,
              ),
              IconButton(
                icon: const CircleAvatar(
                  radius: 10.0,
                  backgroundColor: AppColours.white,
                  child: Icon(Icons.close, size: 14.0, color: Colors.black),
                ),
                onPressed: onClosedClicked,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
