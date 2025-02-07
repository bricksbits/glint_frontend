import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class YourPronounsCard extends StatefulWidget {
  const YourPronounsCard({super.key});

  @override
  State<YourPronounsCard> createState() => _YourPronounsCardState();
}

class _YourPronounsCardState extends State<YourPronounsCard> {
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
                style: AppTheme.headingFour.copyWith(
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
