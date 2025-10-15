import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/onboarding/show_and_upload_pictures_containers.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/people/state/people_screen_state.dart';
import 'package:glint_frontend/features/profile/bloc/edit/profile_edit_cubit.dart';
import 'package:glint_frontend/features/profile/bloc/profile_handling_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileEditCubit(),
      child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColours.white,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: AppColours.white,
              actions: [
                // save icon
                Container(
                  height: 44.0,
                  width: 44.0,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColours.black,
                  ),
                  child: SvgPicture.asset(
                    'lib/assets/icons/profile/save_icon.svg',
                  ),
                ),

                //gap
                const Gap(12.0),

                // preview icon
                GestureDetector(
                  onTap: () {
                    context.pushNamed(GlintProfileRoutes.profilePreview.name);
                  },
                  child: Container(
                    height: 44.0,
                    width: 44.0,
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

                const Gap(20.0), // for design replication purpose
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                bottom: 20.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(12.0),
                    // images container
                    const ShowAndUploadPicturesContainers(),

                    //get verified
                    const Gap(32.0),
                    GetVerifiedWidget(
                      name: state.previewProfileModel?.username ?? "Username",
                      age: int.parse(state.previewProfileModel?.age ?? "18"),
                      onTap: () {
                        //Todo: Remove this navigation
                        context
                            .pushNamed(GlintProfileRoutes.ticketHistory.name);
                      },
                    ),

                    const Gap(32.0),

                    //im looking for card
                    ImLookingForCard(
                      lookingFor: state.previewProfileModel?.lookingFor ?? "",
                      lookingForCallback: (lookingFor) {
                        context
                            .read<ProfileEditCubit>()
                            .updateRelationshipGoal(lookingFor);
                      },
                    ),

                    const Gap(16.0),

                    // pronouns card
                    YourPronounsCard(
                      genderPassed: state.previewProfileModel?.gender,
                      pronounsSelected: (pronouns) {
                        context
                            .read<ProfileEditCubit>()
                            .updatePronouns(pronouns);
                      },
                    ),

                    const Gap(20.0),

                    // Interests and Vibe
                    _buildInterestsAndVibeSections(
                      state.previewProfileModel?.interests ?? [],
                    ),

                    const Gap(20.0),

                    // enter bio
                    EnterYourBio(
                      onBioCompleted: (newBio) {
                        context.read<ProfileEditCubit>()
                            .updateBio(newBio);
                      },
                      bio: state.previewProfileModel?.bio ?? "",
                    ),

                    // Additional info
                    const Gap(24.0),

                    AdditionalInfoContainer(
                      occupation: state.previewProfileModel?.occupation,
                      education: state.previewProfileModel?.about["education"],
                      height: state.previewProfileModel?.about["height"],
                      workoutHabits:
                          state.previewProfileModel?.about["workout"],
                      drinkingHabits:
                          state.previewProfileModel?.about["drinking"],
                      smokingHabits:
                          state.previewProfileModel?.about["smoking"],
                      occupationProvided: (occupation) {
                        context
                            .read<ProfileEditCubit>()
                            .updateOccupation(occupation);
                      },
                      educationSelected: (education) {
                        context
                            .read<ProfileEditCubit>()
                            .updateOccupation(education);
                      },
                      heightProvided: (height) {
                        context.read<ProfileEditCubit>().updateHeight(
                              height.toString(),
                            );
                      },
                      workoutHabitSelected: (workout) {
                        context
                            .read<ProfileEditCubit>()
                            .updateWorkoutHabits(workout);
                      },
                      drinkingHabitSelected: (drinking) {
                        context
                            .read<ProfileEditCubit>()
                            .updateWorkoutHabits(drinking);
                      },
                      smokingHabitSelected: (smoking) {
                        context
                            .read<ProfileEditCubit>()
                            .updateWorkoutHabits(smoking);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Interest and Vibe Selection
  Widget _buildInterestsAndVibeSections(
    List<String> interests,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interests & Vibe',
          style: AppTheme.headingFour.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(16.0),
        GlintInterestsSelection(
          selectedInterests:
              mapInterestsToLabelIconList(userInterests: interests),
        ),
      ],
    );
  }
}
