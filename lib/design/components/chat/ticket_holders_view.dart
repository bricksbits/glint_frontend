import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_theme.dart';

import '../../common/app_colours.dart';

class TicketHolderView extends StatelessWidget {
  const TicketHolderView(
      {super.key,
      required this.person1Name,
      required this.person2Name,
      required this.totalAmount});

  final String person1Name;
  final String person2Name;
  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // top side - labels and amount paid
          Row(
            children: [
              Text(
                'Ticket Holder(s)',
                style: AppTheme.simpleBodyText.copyWith(
                  color: AppColours.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Amount Paid : ',
                      style: AppTheme.smallBodyText.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColours.white,
                      ),
                    ),
                    TextSpan(
                      text: '₹499',
                      style: AppTheme.smallBodyText.copyWith(
                        color: AppColours.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Gap(16.0),

          //bottom side - ticket holders
          Row(
            children: [
              _buildUserAvatar(
                imageUrl: 'lib/assets/images/temp_place_holder.png',
                name: 'Shubham (You)',
              ),
              const Gap(20.0),
              _buildUserAvatar(
                imageUrl: 'lib/assets/images/temp_place_holder.png',
                name: 'Gajgamini',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar({required String imageUrl, required String name}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage(imageUrl),
        ),
        const Gap(8.0),
        Text(
          name,
          style: AppTheme.simpleText.copyWith(
            color: AppColours.white,
          ),
        ),
      ],
    );
  }
}
