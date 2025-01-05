import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GetSetGlintOnboardingScreen extends StatefulWidget {
  const GetSetGlintOnboardingScreen({super.key});

  @override
  State<GetSetGlintOnboardingScreen> createState() =>
      _GetSetGlintOnboardingScreenState();
}

class _GetSetGlintOnboardingScreenState
    extends State<GetSetGlintOnboardingScreen> {
  String? _lookingFor;
  String? _pronouns;
  bool _choseCustomPronoun = false;

  final _customPronounsController = TextEditingController();

  void settingCustomPronouns(BuildContext context) {
    setState(() {
      _pronouns = null;
    });

    showCustomPronounsBottomSheet(context);
  }

  void showCustomPronounsBottomSheet(BuildContext context) {
    context.showBottomSheet(
      (context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0).copyWith(
              bottom: 60.0,
              top: 28.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter your Pronouns',
                  style: AppTheme.headingTwo.copyWith(fontSize: 20.0),
                ),
                const Gap(32.0),
                SizedBox(
                  width: double.infinity,
                  child: GlintTextInputField(
                    controller: _customPronounsController,
                    hintText: 'Ex: He/Him',
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          _choseCustomPronoun = true;
                          _pronouns = _customPronounsController.text.trim();
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        color: AppColours.primaryBlue,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
                const Gap(60.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Skip >>',
                    style: AppTheme.simpleText.copyWith(
                      color: AppColours.gray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0)
              .copyWith(bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Get, Set, ',
                  style: AppTheme.headingOne.copyWith(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  children: [
                    TextSpan(
                      text: 'Glint',
                      style: AppTheme.headingOne.copyWith(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8.0),

              // sub heading
              const Text(
                'Set your vibe and let the sparks fly!',
                style: AppTheme.smallBodyText,
              ),
              const Gap(60.0),

              _buildLookingForCard(),

              const Gap(16.0),

              // pronouns card
              _buildPronounsWidget(),

              const Spacer(
                flex: 12,
              ),

              // submit button
              SizedBox(
                width: double.infinity,
                child: GlintElevatedButton(
                  label: 'Next',
                  foregroundColor: Colors.white,
                  backgroundColor: AppColours.primaryBlue,
                  onPressed: () {
                    // TODO: Handle navigation or next step
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // im looking for card
  Widget _buildLookingForCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: AppColours.backgroundShade,
        borderRadius: BorderRadius.circular(20.0),
        image: const DecorationImage(
          image: AssetImage(
            'lib/assets/images/onboarding/get_set_glint_illustration.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "I'm Looking For",
              style: AppTheme.headingThree.copyWith(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Gap(16.0),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: [
                GlintCustomLabelChip(
                  label: 'Long-Term',
                  isSelected: _lookingFor == 'Long-Term',
                  onTap: () => setState(() => _lookingFor = 'Long-Term'),
                ),
                GlintCustomLabelChip(
                  label: 'Something Casual',
                  isSelected: _lookingFor == 'Something Casual',
                  onTap: () => setState(() => _lookingFor = 'Something Casual'),
                ),
                GlintCustomLabelChip(
                  label: 'New Friends',
                  isSelected: _lookingFor == 'New Friends',
                  onTap: () => setState(() => _lookingFor = 'New Friends'),
                ),
                GlintCustomLabelChip(
                  label: 'Not Sure',
                  isSelected: _lookingFor == 'Not Sure',
                  onTap: () => setState(() => _lookingFor = 'Not Sure'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// pronouns widget
  Widget _buildPronounsWidget() {
    final customPronoun = _customPronounsController.text.trim();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: AppColours.lightGray,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Your Pronouns',
                style: AppTheme.headingThree.copyWith(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Gap(16.0),
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  GlintCustomLabelChip(
                    label: 'He/Him',
                    isSelected: _pronouns == 'He/Him',
                    onTap: () => setState(() => _pronouns = 'He/Him'),
                  ),
                  GlintCustomLabelChip(
                    label: 'She/Her',
                    isSelected: _pronouns == 'She/Her',
                    onTap: () => setState(() => _pronouns = 'She/Her'),
                  ),
                  GlintCustomLabelChip(
                    label: 'They/Them',
                    isSelected: _pronouns == 'They/Them',
                    onTap: () => setState(() => _pronouns = 'They/Them'),
                  ),
                  GlintCustomLabelChip(
                    label: 'Prefer not to say',
                    isSelected: _pronouns == 'Prefer not to say',
                    onTap: () =>
                        setState(() => _pronouns = 'Prefer not to say'),
                  ),

                  // custom add button if not already set custom
                  if (!_choseCustomPronoun)
                    GestureDetector(
                      onTap: () => settingCustomPronouns(context),
                      onDoubleTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColours.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColours.gray,
                            width: 0.4,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(7.6),
                          child: Icon(
                            Icons.add,
                            color: Colors.black87,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  // after setting custom pronouns
                  if (_choseCustomPronoun)
                    GlintCustomLabelChip(
                      label: customPronoun,
                      isSelected: _pronouns == customPronoun,
                      onTap: () => setState(
                        () => _pronouns = customPronoun,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
