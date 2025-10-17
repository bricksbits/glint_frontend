import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/features/profile/bloc/profile_handling_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileHandlingCubit(),
      child: BlocBuilder<ProfileHandlingCubit, ProfileHandlingState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColours.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileInfoColumn(
                      profileProgress:
                          state.previewProfileModel?.profileCompletion ?? 0.6,
                      userName:
                          state.previewProfileModel?.username ?? "Username",
                      userAge: state.previewProfileModel?.age ?? "18",
                      userProfileImageUrl: state.previewProfileModel
                              ?.pictureUrlList.firstOrNull ??
                          "https://www.glintapp.io",
                    ),
                    ProfileSubscriptionColumn(
                      superLikeCounts: state.membershipEntity?.superLikes ?? 0,
                      rewindCounts: state.membershipEntity?.rewinds ?? 0,
                      superDmCounts: state.membershipEntity?.superDm ?? 0,
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
}
