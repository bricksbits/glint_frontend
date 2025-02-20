import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class EnterYourBio extends StatefulWidget {
  const EnterYourBio({super.key});

  @override
  State<EnterYourBio> createState() => _EnterYourBioState();
}

class _EnterYourBioState extends State<EnterYourBio> {
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const defaultBorder = BorderSide(
      color: AppColours.primaryBlue,
      width: 1.0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter your Bio',
          style: AppTheme.headingFour,
        ),
        const Gap(8.0),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColours.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border(
              top: defaultBorder,
              left: defaultBorder,
              right: defaultBorder,
              bottom: defaultBorder.copyWith(width: 3.0),
            ),
          ),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autocorrect: true,
            maxLength: 200,
            controller: _bioController,
            cursorColor: AppColours.primaryBlue,
            style: AppTheme.simpleBodyText.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              color: AppColours.black,
            ),
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              counter: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColours.primaryBlue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${_bioController.text.length} / 200',
                    style: AppTheme.simpleText.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColours.white,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
