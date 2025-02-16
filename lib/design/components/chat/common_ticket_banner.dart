import 'package:flutter/material.dart';

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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'lib/assets/images/chat/chat_ticket_info_pace_holder.png'),
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
                icon: const Icon(Icons.info, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
