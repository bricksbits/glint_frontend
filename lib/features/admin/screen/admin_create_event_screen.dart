import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/create_event_request.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/features/admin/bloc/create/admin_create_event_cubit.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

enum EventType { hot, normal, notMentioned }

class AdminCreateEventScreen extends StatefulWidget {
  const AdminCreateEventScreen({
    super.key,
    required this.navArguments,
  });

  final AdminCreateEventNavArguments? navArguments;

  @override
  State<AdminCreateEventScreen> createState() => _AdminCreateEventScreenState();
}

class _AdminCreateEventScreenState extends State<AdminCreateEventScreen> {
  late final TextEditingController _eventNameController =
      TextEditingController();
  late final TextEditingController _actualPriceController =
      TextEditingController();
  late final TextEditingController _discountPriceController =
      TextEditingController();
  late final TextEditingController _locationController =
      TextEditingController();
  late final TextEditingController _eventDescriptionController =
      TextEditingController();

  EventType _selectedChip = EventType.normal;
  int _selectedNumberOfPerson = 10;

  String? _selectedStartDate;
  String? _selectedStartTime;
  String? _selectedEndDate;
  String? _selectedEndTime;

  final List<Map<EventType, String>> eventTypeOptions = [
    {
      EventType.hot: '🔥 Hot Event',
    },
    {
      EventType.normal: 'Normal',
    },
  ];

  @override
  void dispose() {
    _eventNameController.dispose();
    _actualPriceController.dispose();
    _discountPriceController.dispose();
    _locationController.dispose();
    _eventDescriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context
        .read<AdminCreateEventCubit>()
        .getEventDetailsAndUpdateTheCreateEventBody(
          widget.navArguments?.updateExistingEventId,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCreateEventCubit, AdminCreateEventState>(
      listener: (context, state) {
        if (state.eventPublished) {
          print("CALL BACK CALLED");
          widget.navArguments?.onReturn.call("updated");
          context.pop();
        }

        if (state.eventUpdated) {
          context.pop();
          context.goNamed(
            GlintAdminDasboardRoutes.liveEvent.name,
            extra: state.createEventBody?.mapToDomainModel(),
          );
        }

        if (state.createEventBody != null) {
          final currentEventState = state.createEventBody;
          _eventNameController.text = currentEventState?.eventName ?? "";
          _actualPriceController.text =
              currentEventState?.originalPrice.toString() ?? "";
          _discountPriceController.text =
              currentEventState?.discountedPrice.toString() ?? "";
          _eventDescriptionController.text =
              currentEventState?.eventDescription ?? "";
          _locationController.text = currentEventState?.eventLocationName ?? "";
          _selectedChip = currentEventState?.isHotEvent ?? false
              ? EventType.hot
              : EventType.normal;

          _selectedNumberOfPerson = currentEventState?.totalTicket ?? 10;

          _selectedStartDate = currentEventState?.startDateAndTime;
          _selectedStartTime = currentEventState?.startDateAndTime;

          _selectedEndDate = currentEventState?.endDateAndTime;
          _selectedEndTime = currentEventState?.endDateAndTime;
        }
      },
      child: BlocBuilder<AdminCreateEventCubit, AdminCreateEventState>(
        builder: (context, state) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
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
                      context.read<AdminCreateEventCubit>().publishEvent(
                          widget.navArguments?.updateExistingEventId);
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
                      if (state.currentUserType == UsersType.SUPER_ADMIN) {
                        context.pushNamed(
                          GlintAdminDasboardRoutes.previewEvent.name,
                          extra: EventDetailsNavArguments(
                            eventId: null,
                            eventDetails: state.eventDetailModel,
                            unUploadedFiles: null,
                          ),
                        );
                      }
                      if (state.currentUserType == UsersType.ADMIN) {
                        context.pushNamed(
                          GlintAdminDasboardRoutes.previewEvent.name,
                          extra: EventDetailsNavArguments(
                            eventId: null,
                            eventDetails: state.eventDetailModel,
                            unUploadedFiles:
                                state.eventDetailModel?.eventCoverImageUrl !=
                                            null &&
                                        state.eventDetailModel!
                                            .eventCoverImageUrl.isEmpty
                                    ? state.pictureUploaded
                                    : [],
                          ),
                        );
                      }
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
              body: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0)
                            .copyWith(
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
                              _buildEventStartDatePicker(),

                              const Gap(12.0),
                              //event time picker
                              _buildEventStartTimePicker(),

                              const Gap(24.0),
                              // event date picker
                              _buildEventEndDatePicker(),

                              const Gap(12.0),
                              //event time picker
                              _buildEventEndTimePicker(),

                              const Gap(12.0),
                              //event location picker
                              _buildEventLocationField(),

                              const Gap(24.0),

                              // event images upload container
                              widget.navArguments?.updateExistingEventId != null
                                  ? _buildEventImagesUploadContainer(() {
                                      context
                                          .read<AdminCreateEventCubit>()
                                          .pickUpImages();
                                    }, (fileToRemove) {
                                      // context
                                      //     .read<AdminCreateEventCubit>()
                                      //     .pickUpImages();
                                    },
                                      context
                                          .read<AdminCreateEventCubit>()
                                          .state
                                          .pictureUploaded,
                                      context
                                          .read<AdminCreateEventCubit>()
                                          .state
                                          .eventDetailModel
                                          ?.eventCoverImageUrl,
                                      state.eventDetailModel?.eventCoverImageUrl
                                              .length
                                              .toString() ??
                                          "")
                                  : const SizedBox.shrink(),

                              const Gap(36.0),
                              // enter event description
                              _buildEventDescriptionField(),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          );
        },
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
          onChanged: (newValue) {
            context
                .read<AdminCreateEventCubit>()
                .observeEventTitle(_eventNameController.text);
          },
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
                  context
                      .read<AdminCreateEventCubit>()
                      .enterEventTyped(chipEnum);
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
            context.read<AdminCreateEventCubit>().enterNumberOfPerson(selected);
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
          onChanged: (newValue) {
            context
                .read<AdminCreateEventCubit>()
                .enterEventActualPrice(int.parse(newValue));
          },
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
          onChanged: (discountPrice) {
            context.read<AdminCreateEventCubit>().enterEventDiscountedPrice(
                int.parse(_discountPriceController.text));
          },
        ),
      ],
    );
  }

  Widget _buildEventStartDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Event Start Date*',
          style: AppTheme.smallBodyText,
        ),
        const Gap(10.0),
        CreateEventSuffixIconField(
          onPressed: () {
            showBottomDatePicker((startDate) {
              context
                  .read<AdminCreateEventCubit>()
                  .collectEventStartDate(startDate);
              String formattedDate =
                  DateFormat('dd/MMM/yyyy').format(startDate);
              setState(() {
                _selectedStartDate = formattedDate;
              });
            });
          },
          assetPath: 'lib/assets/icons/calendar_icon.svg',
          child: _selectedStartDate == null
              ? const SizedBox.shrink()
              : Text(
                  _selectedStartDate!,
                  style: AppTheme.simpleText,
                ),
        ),
      ],
    );
  }

  Widget _buildEventStartTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Event Start Time*',
          style: AppTheme.smallBodyText,
        ),
        const Gap(10.0),
        CreateEventSuffixIconField(
          onPressed: () {
            showBottomTimePicker((timeSelected) {
              context.read<AdminCreateEventCubit>().collectEventStartTime(
                    timeSelected,
                  );
              String formattedTime = DateFormat('hh:mm a').format(timeSelected);
              setState(() {
                _selectedStartTime = formattedTime;
              });
            });
          },
          icon: Icons.timelapse_rounded,
          child: _selectedStartTime == null
              ? const SizedBox.shrink()
              : Text(
                  _selectedStartTime!,
                  style: AppTheme.simpleText,
                ),
        ),
      ],
    );
  }

  Widget _buildEventEndDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Event End Date*',
          style: AppTheme.smallBodyText,
        ),
        const Gap(10.0),
        CreateEventSuffixIconField(
          onPressed: () {
            showBottomDatePicker((endDate) {
              context
                  .read<AdminCreateEventCubit>()
                  .collectEventEndDate(endDate);
              String formattedDate = DateFormat('dd/MMM/yyyy').format(endDate);
              setState(() {
                _selectedEndDate = formattedDate;
              });
            });
          },
          assetPath: 'lib/assets/icons/calendar_icon.svg',
          child: _selectedEndDate == null
              ? const SizedBox.shrink()
              : Text(
                  _selectedEndDate!,
                  style: AppTheme.simpleText,
                ),
        ),
      ],
    );
  }

  Widget _buildEventEndTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Event Start Time*',
          style: AppTheme.smallBodyText,
        ),
        const Gap(10.0),
        CreateEventSuffixIconField(
          onPressed: () {
            showBottomTimePicker((endTime) {
              context
                  .read<AdminCreateEventCubit>()
                  .collectEventEndTime(endTime);
              String formattedTime = DateFormat('hh:mm a').format(endTime);
              setState(() {
                _selectedEndTime = formattedTime;
              });
            });
          },
          icon: Icons.timelapse_rounded,
          child: _selectedEndTime == null
              ? const SizedBox.shrink()
              : Text(
                  _selectedEndTime!,
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
            maxLength: 70,
            // todo - check if needs change
            style: AppTheme.simpleText,
            decoration: const InputDecoration(
              border: InputBorder.none,
              counter: SizedBox.shrink(),
            ),
            controller: _locationController,
            onChanged: (newLocationName) {
              context.read<AdminCreateEventCubit>().enterEventLocationName(
                    _locationController.text,
                  );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventImagesUploadContainer(
    VoidCallback onImagePickUp,
    Function(File) onImageRemoved,
    List<File?>? selectedImagesFileList,
    List<String?>? fetchedEventImagesList,
    String tempText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Event Images*',
          style: AppTheme.smallBodyText,
        ),
        const Gap(16.0),
        UploadEventImagesContainers(
          selectedImagesFileList: selectedImagesFileList,
          fetchedEventImagesList: fetchedEventImagesList,
          onImagePickUp: onImagePickUp,
          onImageRemoved: onImageRemoved,
        ),
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
            maxLines: 20,
            autocorrect: true,
            onChanged: (eventDescription) {
              context
                  .read<AdminCreateEventCubit>()
                  .enterEventDescription(eventDescription);
            },
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

  void showBottomTimePicker(
    Function(DateTime) onTimeSelected,
  ) {
    BottomPicker.time(
      use24hFormat: false,
      onSubmit: (time) {
        onTimeSelected(time);
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

  void showBottomDatePicker(
    Function(DateTime) onDateSelected,
  ) {
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
        onDateSelected(date);
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
}
