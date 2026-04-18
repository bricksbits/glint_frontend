import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';

import '../../common/app_colours.dart';

class TicketHolderView extends StatelessWidget {
  const TicketHolderView({
    super.key,
    required this.person1,
    required this.person2,
    required this.totalAmount,
  });

  final UserTicketHolderModel person1;
  final UserTicketHolderModel person2;
  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
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
                      text: '₹$totalAmount',
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
          Row(
            children: [
              _TicketHolderAvatar(holder: person1),
              const Gap(20.0),
              _TicketHolderAvatar(holder: person2),
            ],
          ),
        ],
      ),
    );
  }
}

class _TicketHolderAvatar extends StatelessWidget {
  const _TicketHolderAvatar({required this.holder});

  final UserTicketHolderModel holder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColours.borderGray,
          backgroundImage: holder.imageUrl.startsWith('http')
              ? CachedNetworkImageProvider(holder.imageUrl)
              : AssetImage(holder.imageUrl) as ImageProvider,
        ),
        const Gap(8.0),
        Text(
          holder.username,
          style: AppTheme.simpleText.copyWith(color: AppColours.white),
        ),
      ],
    );
  }
}
