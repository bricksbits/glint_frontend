import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class InterestedPeopleWidget extends StatelessWidget {
  const InterestedPeopleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0).copyWith(
        bottom: 12.0,
      ),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColours.borderGray,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Interested People',
              style: AppTheme.headingFour.copyWith(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          const Gap(20.0),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColours.borderGray,
                  width: 1.0,
                ),
              ),
            ),
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: InterestedPeopleListTiles(
                    limitCount: 5,
                  ),
                ),

                // white overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.2),
                          Colors.white.withValues(alpha: 0.4),
                          Colors.white.withValues(alpha: 0.8),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(12.0),
          InkWell(
            onTap: () {
              context.go(
                "/${GlintAdminDasboardRoutes.interestedUsers.name}"
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'See all interested people',
                  style: AppTheme.simpleText.copyWith(
                    color: AppColours.primaryBlue,
                  ),
                ),
                const Gap(4.0),
                const Icon(
                  Icons.double_arrow_outlined,
                  color: AppColours.primaryBlue,
                  size: 12.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
