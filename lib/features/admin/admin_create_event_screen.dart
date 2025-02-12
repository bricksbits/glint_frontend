import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:intl/intl.dart';

enum EventType { hot, normal }

class AdminCreateEventScreen extends StatefulWidget {
  const AdminCreateEventScreen({super.key});

  @override
  State<AdminCreateEventScreen> createState() => _AdminCreateEventScreenState();
}

class _AdminCreateEventScreenState extends State<AdminCreateEventScreen> {
  // data we need from manager
  final _eventNameController = TextEditingController();
  EventType _selectedChip = EventType.hot;
  int _selectedNumberOfPerson = 10;
  final _actualPriceController = TextEditingController();
  final _discountPriceController = TextEditingController();
  String? _selectedDate;
  String? _selectedTime;
  final _locationController = TextEditingController();
  final _eventDescriptionController = TextEditingController();

// functions or static vars
  final List<Map<EventType, String>> eventTypeOptions = [
    {
      EventType.hot: '🔥 Hot Event',
    },
    {
      EventType.normal: 'Normal',
    },
  ];

  void showBottomTimePicker() {
    BottomPicker.time(
      use24hFormat: false,
      onSubmit: (time) {
        String formattedTime = DateFormat('hh:mm a').format(time);
        setState(() {
          _selectedTime = formattedTime;
        });
      },
      dismissable: true,
      displayCloseIcon: false,
      bottomPickerTheme: BottomPickerTheme.plumPlate,
      pickerTitle: const SizedBox.shrink(),
      buttonWidth: 200.0,
      gradientColors: const [
        AppColours.primaryBlue,
        AppColours.purpleShade,
      ],
      initialTime: Time.now(),
    ).show(context);
  }

  void showBottomDatePicker() {
    BottomPicker.date(
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 1,
      ),
      pickerTextStyle: AppTheme.simpleText.copyWith(
        fontSize: 16.0,
      ),
      maxDateTime: DateTime(
        DateTime.now().year + 10,
        DateTime.now().month,
        DateTime.now().day,
      ),
      minDateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day - 1,
      ),
      onSubmit: (date) {
        String formattedDate = DateFormat('dd/MMM/yyyy').format(date);
        setState(() {
          _selectedDate = formattedDate;
        });
      },
      dismissable: true,
      displayCloseIcon: false,
      bottomPickerTheme: BottomPickerTheme.plumPlate,
      pickerTitle: const SizedBox.shrink(),
      buttonWidth: 200.0,
      gradientColors: const [
        AppColours.primaryBlue,
        AppColours.purpleShade,
      ],
    ).show(context);
  }

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
        scrolledUnderElevation: 0,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0).copyWith(
            bottom: 28.0,
          ),
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

                //discount price
                _buildDiscountPriceField(),

                const Gap(24.0),
                // event date picker
                _buildEventDatePicker(),

                const Gap(12.0),
                //event time picker
                _buildEventTimePicker(),

                const Gap(12.0),
                //event location picker
                _buildEventLocationField(),

                const Gap(24.0),
                // event images upload container
                _buildEventImagesUploadContainer(),

                const Gap(36.0),
                // enter event description
                _buildEventDescriptionField(),
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

  Widget _buildEventDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Event Date*',
          style: AppTheme.smallBodyText,
        ),
        const Gap(10.0),
        CreateEventSuffixIconField(
          onPressed: showBottomDatePicker,
          assetPath: 'lib/assets/icons/calendar_icon.svg',
          child: _selectedDate == null
              ? const SizedBox.shrink()
              : Text(
                  _selectedDate!,
                  style: AppTheme.simpleText,
                ),
        ),
      ],
    );
  }

  Widget _buildEventTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Event Time*',
          style: AppTheme.smallBodyText,
        ),
        const Gap(10.0),
        CreateEventSuffixIconField(
          onPressed: showBottomTimePicker,
          icon: Icons.timelapse_rounded,
          child: _selectedTime == null
              ? const SizedBox.shrink()
              : Text(
                  _selectedTime!,
                  style: AppTheme.simpleText,
                ),
        ),
      ],
    );
  }

  Widget _buildEventLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Event Location*',
          style: AppTheme.smallBodyText,
        ),
        const Gap(10.0),
        CreateEventSuffixIconField(
          icon: Icons.location_on_outlined,
          child: TextField(
            maxLength: 70, // todo - check if needs change
            style: AppTheme.simpleText,
            decoration: const InputDecoration(
              border: InputBorder.none,
              counter: SizedBox.shrink(),
            ),
            controller: _locationController,
          ),
        ),
      ],
    );
  }

  Widget _buildEventImagesUploadContainer() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Event Images*',
          style: AppTheme.smallBodyText,
        ),
        Gap(16.0),
        UploadEventImagesContainers(),
      ],
    );
  }

  Widget _buildEventDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Event Description*',
          style: AppTheme.smallBodyText,
        ),
        const Gap(12.0),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColours.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: AppColours.backgroundShade,
              width: 1.0,
            ),
          ),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autocorrect: true,
            controller: _eventDescriptionController,
            cursorColor: AppColours.primaryBlue,
            style: AppTheme.simpleText,
            decoration: const InputDecoration(
              counter: SizedBox.shrink(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
