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
import 'package:glint_frontend/features/admin/bloc/create/admin_create_event_cubit.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

enum EventType { hot, normal, notMentioned }

const _kCategories = ['Music', 'Meetup', 'Social'];

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
  late final TextEditingController _googleMapUrlController =
      TextEditingController();
  late final TextEditingController _latController = TextEditingController();
  late final TextEditingController _longController = TextEditingController();
  late final TextEditingController _eventByController =
      TextEditingController();

  final List<Map<EventType, String>> eventTypeOptions = [
    {EventType.hot: '🔥 Hot Event'},
    {EventType.normal: 'Normal'},
  ];

  @override
  void dispose() {
    _eventNameController.dispose();
    _actualPriceController.dispose();
    _discountPriceController.dispose();
    _locationController.dispose();
    _eventDescriptionController.dispose();
    _googleMapUrlController.dispose();
    _latController.dispose();
    _longController.dispose();
    _eventByController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context
        .read<AdminCreateEventCubit>()
        .getEventDetailsAndUpdateTheCreateEventBody(
          widget.navArguments?.updateExistingEventId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCreateEventCubit, AdminCreateEventState>(
      // Only populate text controllers once — when existing event details finish loading.
      listenWhen: (previous, current) =>
          previous.isLoading && !current.isLoading && current.eventDetailModel != null,
      listener: (context, state) {
        final body = state.createEventBody;
        if (body == null) return;
        _eventNameController.text = body.eventName;
        _actualPriceController.text = body.originalPrice.toString();
        _discountPriceController.text = body.discountedPrice.toString();
        _eventDescriptionController.text = body.eventDescription;
        _locationController.text = body.eventLocationName;
        _googleMapUrlController.text = body.googleMapUrl;
        _latController.text =
            body.eventLocationLat != 0.0 ? body.eventLocationLat.toString() : '';
        _longController.text =
            body.eventLocationLong != 0.0 ? body.eventLocationLong.toString() : '';
        _eventByController.text = body.eventBy;
      },
      child: BlocConsumer<AdminCreateEventCubit, AdminCreateEventState>(
        listenWhen: (_, current) =>
            current.eventPublished || current.eventUpdated || current.error.isNotEmpty,
        listener: (context, state) {
          if (state.eventPublished) {
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

          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: AppColours.white,
              appBar: AppBar(
                titleSpacing: 32.0,
                scrolledUnderElevation: 0,
                title: Text(
                  widget.navArguments?.updateExistingEventId != null
                      ? 'Edit Event'
                      : 'Create Event',
                  style: AppTheme.heavyBodyText,
                ),
                centerTitle: false,
                backgroundColor: AppColours.white,
                actions: [
                  // Publish button
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

                  const Gap(12.0),

                  // Preview button
                  GestureDetector(
                    onTap: () {
                      final previewDetails =
                          state.eventDetailModel ?? state.createEventBody?.toPreviewEventDetails();

                      if (previewDetails == null) return;

                      context.pushNamed(
                        GlintAdminDasboardRoutes.previewEvent.name,
                        extra: EventDetailsNavArguments(
                          eventId: null,
                          eventDetails: previewDetails,
                          unUploadedFiles: state.eventDetailModel == null ||
                                  state.eventDetailModel!.eventCoverImageUrl.isEmpty
                              ? state.pictureUploaded
                              : [],
                        ),
                      );
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
                            .copyWith(bottom: 28.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(20.0),
                            _buildEventNameTextField(),
                            const Gap(24.0),
                            _buildEventTypeSelector(state),
                            const Gap(20.0),
                            _buildCategorySelector(state),
                            const Gap(20.0),
                            _builtNumberOfPersonSelector(state),
                            const Gap(24.0),
                            _buildActualPriceField(),
                            const Gap(12.0),
                            _buildDiscountPriceField(),
                            const Gap(12.0),
                            _buildDiscountToggle(state),
                            const Gap(24.0),
                            _buildEventStartDatePicker(state),
                            const Gap(12.0),
                            _buildEventStartTimePicker(state),
                            const Gap(24.0),
                            _buildEventEndDatePicker(state),
                            const Gap(12.0),
                            _buildEventEndTimePicker(state),
                            const Gap(12.0),
                            _buildEventLocationField(),
                            const Gap(12.0),
                            _buildEventByField(),
                            const Gap(12.0),
                            _buildGoogleMapUrlField(),
                            const Gap(12.0),
                            _buildLatLongFields(),
                            const Gap(24.0),
                            _buildEventImagesUploadContainer(
                              onImagePickUp: () => context
                                  .read<AdminCreateEventCubit>()
                                  .pickUpImages(),
                              selectedImagesFileList: state.pictureUploaded,
                              fetchedEventImagesList:
                                  state.eventDetailModel?.eventCoverImageUrl,
                            ),
                            const Gap(36.0),
                            _buildEventDescriptionField(),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  // ── Form widgets ──────────────────────────────────────────────────────────

  Widget _buildEventNameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Event Name', style: AppTheme.smallBodyText),
        const Gap(10.0),
        GlintTextInputField(
          controller: _eventNameController,
          borderRadius: 10.0,
          hintText: 'The Indian Food Festival',
          onChanged: (_) {
            context
                .read<AdminCreateEventCubit>()
                .observeEventTitle(_eventNameController.text);
          },
        ),
      ],
    );
  }

  Widget _buildEventTypeSelector(AdminCreateEventState state) {
    final isHot = state.createEventBody?.isHotEvent ?? false;
    final selectedChip = isHot ? EventType.hot : EventType.normal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Event Type:', style: AppTheme.smallBodyText),
        const Gap(16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: eventTypeOptions.map((option) {
            final chipEnum = option.keys.first;
            final chipLabel = option.values.first;
            final isSelected = selectedChip == chipEnum;

            return GestureDetector(
              onTap: () {
                context
                    .read<AdminCreateEventCubit>()
                    .enterEventTyped(chipEnum);
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
                        : AppColours.black,
                  ),
                ),
                backgroundColor: isSelected
                    ? AppColours.chipBackgroundShade
                    : AppColours.white,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategorySelector(AdminCreateEventState state) {
    final selected = state.createEventBody?.categoryList ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Category:', style: AppTheme.smallBodyText),
        const Gap(12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _kCategories.map((category) {
            final isSelected = selected.contains(category);
            return GestureDetector(
              onTap: () {
                context
                    .read<AdminCreateEventCubit>()
                    .toggleCategory(category);
              },
              child: Chip(
                shape: const StadiumBorder(
                  side: BorderSide(
                    color: AppColours.backgroundShade,
                    width: 1.4,
                  ),
                ),
                label: Text(
                  category,
                  style: AppTheme.smallBodyText.copyWith(
                    fontSize: 12.0,
                    color: isSelected
                        ? AppColours.primaryBlue
                        : AppColours.black,
                  ),
                ),
                backgroundColor: isSelected
                    ? AppColours.chipBackgroundShade
                    : AppColours.white,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _builtNumberOfPersonSelector(AdminCreateEventState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Number of Persons:', style: AppTheme.smallBodyText),
        const Gap(10.0),
        NumberOfPersonSelector(
          initialValue: state.createEventBody?.totalTicket ?? 10,
          onChanged: (int selected) {
            context
                .read<AdminCreateEventCubit>()
                .enterNumberOfPerson(selected);
          },
        ),
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
                style:
                    AppTheme.smallBodyText.copyWith(fontWeight: FontWeight.w700),
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
            final parsed = int.tryParse(newValue);
            if (parsed != null) {
              context
                  .read<AdminCreateEventCubit>()
                  .enterEventActualPrice(parsed);
            }
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
                style:
                    AppTheme.smallBodyText.copyWith(fontWeight: FontWeight.w700),
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
          onChanged: (_) {
            final parsed = int.tryParse(_discountPriceController.text);
            if (parsed != null) {
              context
                  .read<AdminCreateEventCubit>()
                  .enterEventDiscountedPrice(parsed);
            }
          },
        ),
      ],
    );
  }

  Widget _buildDiscountToggle(AdminCreateEventState state) {
    final activated = state.createEventBody?.discountActivated ?? false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Discount Activated', style: AppTheme.smallBodyText),
        Switch(
          value: activated,
          activeColor: AppColours.primaryBlue,
          onChanged: (val) {
            context
                .read<AdminCreateEventCubit>()
                .setDiscountActivated(val);
          },
        ),
      ],
    );
  }

  Widget _buildEventStartDatePicker(AdminCreateEventState state) {
    final displayDate = state.selectedStartTime != null
        ? DateFormat('dd/MMM/yyyy').format(state.selectedStartTime!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Event Start Date*', style: AppTheme.smallBodyText),
        const Gap(10.0),
        CreateEventSuffixIconField(
          onPressed: () {
            _showBottomDatePicker((startDate) {
              context
                  .read<AdminCreateEventCubit>()
                  .collectEventStartDate(startDate);
            });
          },
          assetPath: 'lib/assets/icons/calendar_icon.svg',
          child: displayDate != null
              ? Text(displayDate, style: AppTheme.simpleText)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildEventStartTimePicker(AdminCreateEventState state) {
    final displayTime = state.selectedStartTime != null
        ? DateFormat('hh:mm a').format(state.selectedStartTime!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Event Start Time*', style: AppTheme.smallBodyText),
        const Gap(10.0),
        CreateEventSuffixIconField(
          onPressed: () {
            _showBottomTimePicker((timeSelected) {
              context
                  .read<AdminCreateEventCubit>()
                  .collectEventStartTime(timeSelected);
            });
          },
          icon: Icons.timelapse_rounded,
          child: displayTime != null
              ? Text(displayTime, style: AppTheme.simpleText)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildEventEndDatePicker(AdminCreateEventState state) {
    final displayDate = state.selectedEntTime != null
        ? DateFormat('dd/MMM/yyyy').format(state.selectedEntTime!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Event End Date*', style: AppTheme.smallBodyText),
        const Gap(10.0),
        CreateEventSuffixIconField(
          onPressed: () {
            _showBottomDatePicker((endDate) {
              context
                  .read<AdminCreateEventCubit>()
                  .collectEventEndDate(endDate);
            });
          },
          assetPath: 'lib/assets/icons/calendar_icon.svg',
          child: displayDate != null
              ? Text(displayDate, style: AppTheme.simpleText)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildEventEndTimePicker(AdminCreateEventState state) {
    final displayTime = state.selectedEntTime != null
        ? DateFormat('hh:mm a').format(state.selectedEntTime!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Event End Time*', style: AppTheme.smallBodyText),
        const Gap(10.0),
        CreateEventSuffixIconField(
          onPressed: () {
            _showBottomTimePicker((endTime) {
              context
                  .read<AdminCreateEventCubit>()
                  .collectEventEndTime(endTime);
            });
          },
          icon: Icons.timelapse_rounded,
          child: displayTime != null
              ? Text(displayTime, style: AppTheme.simpleText)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildEventLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Event Location*', style: AppTheme.smallBodyText),
        const Gap(10.0),
        CreateEventSuffixIconField(
          icon: Icons.location_on_outlined,
          child: TextField(
            maxLength: 70,
            style: AppTheme.simpleText,
            decoration: const InputDecoration(
              border: InputBorder.none,
              counter: SizedBox.shrink(),
            ),
            controller: _locationController,
            onChanged: (_) {
              context
                  .read<AdminCreateEventCubit>()
                  .enterEventLocationName(_locationController.text);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventByField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Event By', style: AppTheme.smallBodyText),
        const Gap(10.0),
        GlintTextInputField(
          controller: _eventByController,
          borderRadius: 10.0,
          hintText: 'Organiser / Company name',
          onChanged: (_) {
            context
                .read<AdminCreateEventCubit>()
                .enterEventBy(_eventByController.text);
          },
        ),
      ],
    );
  }

  Widget _buildGoogleMapUrlField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Google Map URL', style: AppTheme.smallBodyText),
        const Gap(10.0),
        GlintTextInputField(
          controller: _googleMapUrlController,
          borderRadius: 10.0,
          hintText: 'https://maps.google.com/...',
          onChanged: (_) {
            context
                .read<AdminCreateEventCubit>()
                .enterGoogleMapUrl(_googleMapUrlController.text);
          },
        ),
      ],
    );
  }

  Widget _buildLatLongFields() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Latitude', style: AppTheme.smallBodyText),
              const Gap(10.0),
              _buildCoordInputField(
                controller: _latController,
                hint: '28.6139',
                onChanged: (_) => context
                    .read<AdminCreateEventCubit>()
                    .enterEventLat(_latController.text),
              ),
            ],
          ),
        ),
        const Gap(12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Longitude', style: AppTheme.smallBodyText),
              const Gap(10.0),
              _buildCoordInputField(
                controller: _longController,
                hint: '77.2090',
                onChanged: (_) => context
                    .read<AdminCreateEventCubit>()
                    .enterEventLong(_longController.text),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCoordInputField({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      height: 56.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppColours.backgroundShade, width: 1.0),
      ),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: AppTheme.simpleText,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: AppTheme.simpleText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }

  Widget _buildEventImagesUploadContainer({
    required VoidCallback onImagePickUp,
    required List<File?> selectedImagesFileList,
    required List<String>? fetchedEventImagesList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload Event Images*', style: AppTheme.smallBodyText),
        const Gap(16.0),
        UploadEventImagesContainers(
          selectedImagesFileList: selectedImagesFileList,
          fetchedEventImagesList: fetchedEventImagesList,
          onImagePickUp: onImagePickUp,
          onImageRemoved: (_) {},
        ),
      ],
    );
  }

  Widget _buildEventDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Event Description*', style: AppTheme.smallBodyText),
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

  // ── Pickers ───────────────────────────────────────────────────────────────

  void _showBottomTimePicker(Function(DateTime) onTimeSelected) {
    BottomPicker.time(
      use24hFormat: false,
      onSubmit: (time) => onTimeSelected(time),
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

  void _showBottomDatePicker(Function(DateTime) onDateSelected) {
    BottomPicker.date(
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 1,
      ),
      pickerTextStyle: AppTheme.simpleText.copyWith(fontSize: 16.0),
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
      onSubmit: (date) => onDateSelected(date),
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
