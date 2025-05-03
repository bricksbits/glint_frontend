import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class MatchPopupScreen extends StatelessWidget {
  const MatchPopupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String name = 'Playboi Carti';
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        titleSpacing: 26.0,
        title: SvgPicture.asset(
          'lib/assets/icons/glint_logo.svg',
          colorFilter: const ColorFilter.mode(
            AppColours.white,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            //background image
            Positioned.fill(
              child: Image.asset(
                'lib/assets/images/match_popup_background.png',
                fit: BoxFit.cover,
              ),
            ),

            // content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    const Spacer(),

                    // GLINT!! SVG

                    SvgPicture.asset(
                      'lib/assets/icons/GLINT!!.svg',
                    ),

                    const Gap(48.0),

                    // OVERLAP PROFILE PICTURES
                    const SizedBox(
                      height: 180, // based on the avatar radius (90 * 2)
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: const [
                          Positioned(
                            left: 10,
                            child: CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage(
                                  'https://cdn-images.dzcdn.net/images/artist/b90097972a60d9d8598a79a786be1a3a/1900x1900-000000-80-0-0.jpg'),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            child: CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage(
                                  'https://yt3.googleusercontent.com/hS_DE4MZCZxaY4-BHJcWxyTUA8uxTBtVEqUwa9iSChsfRklTN9YQ12ORdYJFALV96HFJ4jfObA=s900-c-k-c0x00ffffff-no-rj'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Gap(32.0),

                    Text(
                      'It’s a match with ',
                      style: AppTheme.headingTwo.copyWith(
                        color: AppColours.white,
                      ),
                    ),

                    // name
                    const Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Cambon',
                        fontSize: 52.0,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        color: AppColours.vibrantYellow,
                      ),
                    ),

                    const Gap(20.0),

                    SizedBox(
                      height: 49.0,
                      child: GlintIconElevatedButton(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Gap(10.0),
                            const Icon(
                              Icons.quickreply,
                              color: AppColours.black,
                              size: 18.0,
                            ),
                            const Gap(8.0),
                            Text(
                              'Say Hi!!',
                              style: AppTheme.simpleText.copyWith(
                                fontSize: 16.0,
                              ),
                            ),
                            const Gap(10.0),
                          ],
                        ),
                        backgroundColor: AppColours.white,
                        onPressed: () {
                          //todo - add send hi message functionality
                        },
                      ),
                    ),

                    const Gap(44.0),

                    Text(
                      'Continue Swiping >>',
                      style: AppTheme.simpleText.copyWith(
                        color: AppColours.white,
                      ),
                    ),

                    const Gap(32.0),

                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
