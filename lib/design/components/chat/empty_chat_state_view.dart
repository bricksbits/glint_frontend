import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class EmptyChatStateView extends StatelessWidget {
  final bool isEventMatch;
  final String matchUserId;
  final String matchUserName;
  final VoidCallback upgradePlanCallBack;

  const EmptyChatStateView({
    super.key,
    required this.isEventMatch,
    required this.matchUserId,
    required this.matchUserName,
    required this.upgradePlanCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // background image
              Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColours.backgroundShade,
                  borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(20.0),
                    bottom: isEventMatch == false
                        ? Radius.zero
                        : const Radius.circular(20.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      isEventMatch
                          ? 'lib/assets/images/chat/empty_chat_container_illustration_event_match.png'
                          : 'lib/assets/images/chat/empty_chat_container_illustration.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // text
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(80.0),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTheme.headingFour.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColours.black,
                          fontStyle: FontStyle.normal,
                        ),
                        children: [
                          TextSpan(
                              text: isEventMatch
                                  ? 'Got an Event match\nwith '
                                  : 'You have got a\nmatch with '),
                          TextSpan(
                            text: matchUserName,
                            style: AppTheme.headingFour.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColours.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(36.0),
                    Text(
                      'Wait for $matchUserName to message you',
                      style: AppTheme.simpleText.copyWith(
                        color: AppColours.black,
                      ),
                    ),
                  ],
                ),
              ),

              // this is the overlapping profile image without the logo
              Positioned(
                top: -40.0,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: const Offset(22, 0),
                      child: const CircleAvatar(
                        radius: 42.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                              NetworkImage('https://picsum.photos/200'),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, 0),
                      child: const CircleAvatar(
                        radius: 42.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                              NetworkImage('https://picsum.photos/207'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            )),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      ),
                      color: AppColours.black,
                    ),
                    child: Text(
                      'Or Upgrade Plan Now',
                      textAlign: TextAlign.center,
                      style: AppTheme.simpleText.copyWith(
                        color: AppColours.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
