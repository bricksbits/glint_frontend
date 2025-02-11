import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

enum EventType { hot, normal }

class AdminCreateEventScreen extends StatefulWidget {
  const AdminCreateEventScreen({super.key});

  @override
  State<AdminCreateEventScreen> createState() => _AdminCreateEventScreenState();
}

class _AdminCreateEventScreenState extends State<AdminCreateEventScreen> {
  EventType _selectedChip = EventType.hot;
  final List<Map<EventType, String>> eventTypeOptions = [
    {
      EventType.hot: '🔥 Hot Event',
    },
    {
      EventType.normal: 'Normal',
    },
  ];
  final _eventNameController = TextEditingController();

  int _selectedNumberOfPerson = 10;
  final _actualPriceController = TextEditingController();
  final _discountPriceController = TextEditingController();

  @override
  void dispose() {
    _eventNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: AppBar(
        titleSpacing: 32.0,
        title: const Text(
          'Create Event',
          style: AppTheme.heavyBodyText,
        ),
        centerTitle: false,
        backgroundColor: AppColours.white,
        actions: [
          // save icon
          GestureDetector(
            onTap: () {
              // todo - add event publish functionality
            },
            child: Container(
              height: 40.0,
              width: 40.0,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColours.black,
              ),
              child: SvgPicture.asset(
                'lib/assets/icons/profile/save_icon.svg',
              ),
            ),
          ),

          //gap
          const Gap(12.0),

          // preview icon
          GestureDetector(
            onTap: () {
              // todo - add event preview functionality
            },
            child: Container(
              height: 40.0,
              width: 40.0,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColours.primaryBlue,
              ),
              child: SvgPicture.asset(
                'lib/assets/icons/profile/eye_icon.svg',
              ),
            ),
          ),

          const Gap(32.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0).copyWith(
          bottom: 28.0,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20.0),
                // event name text input field
                _buildEventNameTextField(),

                const Gap(24.0),

                // event type selector
                _buildEventTypeSelector(),

                const Gap(20.0),
                // no. of person selector
                _builtNumberOfPersonSelector(),

                const Gap(24.0),

                //actual price
                _buildActualPriceField(),

                const Gap(12.0),

                //discout price
                _buildDiscountPriceField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventNameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Event Name',
                style: AppTheme.smallBodyText,
              ),
              TextSpan(
                text: ' (Not Editable)',
                style: AppTheme.smallBodyText.copyWith(
                  color: AppColours.gray60,
                ),
              ),
            ],
          ),
        ),
        const Gap(10.0),
        // input field
        GlintTextInputField(
          controller: _eventNameController,
          borderRadius: 10.0,
          hintText: 'The Indian Food Festival',
        ),
      ],
    );
  }

  Widget _buildEventTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Event Type:',
          style: AppTheme.smallBodyText,
        ),
        const Gap(16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: eventTypeOptions.map(
            (option) {
              final chipEnum = option.keys.first;
              final chipLabel = option.values.first;
              final isSelected = _selectedChip == chipEnum;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedChip = chipEnum;
                  });
                  print(_selectedChip);
                },
                child: Chip(
                  shape: const StadiumBorder(
                    side: BorderSide(
                      color: AppColours.backgroundShade,
                      width: 1.4,
                    ),
                  ),
                  label: Text(
                    chipLabel,
                    style: AppTheme.smallBodyText.copyWith(
                        fontSize: 12.0,
                        color: isSelected
                            ? AppColours.primaryBlue
                            : AppColours.black),
                  ),
                  backgroundColor: isSelected
                      ? AppColours.chipBackgroundShade
                      : AppColours.white,
                ),
              );
            },
          ).toList(),
        )
      ],
    );
  }

  Widget _builtNumberOfPersonSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Number of Persons:',
          style: AppTheme.smallBodyText,
        ),
        const Gap(10.0),
        NumberOfPersonSelector(
          initialValue: _selectedNumberOfPerson,
          onChanged: (int selected) {
            setState(() {
              _selectedNumberOfPerson = selected;
            });
            debugPrint('Selected number : $selected');
          },
        )
      ],
    );
  }

  Widget _buildActualPriceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Actual Price',
                style: AppTheme.smallBodyText
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const TextSpan(
                text: ' of ticket per person',
                style: AppTheme.smallBodyText,
              ),
            ],
          ),
        ),
        const Gap(10.0),
        PriceInputField(
          controller: _actualPriceController,
        ),
      ],
    );
  }

  Widget _buildDiscountPriceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Discount Price',
                style: AppTheme.smallBodyText
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const TextSpan(
                text: ' (This amount will be charged)',
                style: AppTheme.smallBodyText,
              ),
            ],
          ),
        ),
        const Gap(10.0),
        PriceInputField(
          controller: _discountPriceController,
        ),
      ],
    );
  }
}
