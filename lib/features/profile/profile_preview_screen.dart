import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';
import 'package:glint_frontend/features/profile/bloc/preview/profile_preview_cubit.dart';
import 'package:glint_frontend/features/profile/bloc/profile_handling_cubit.dart';

class ProfilePreviewScreen extends StatelessWidget {
  const ProfilePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePreviewCubit(),
      child: BlocBuilder<ProfilePreviewCubit, ProfilePreviewState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: AppColours.white,
              title: Text(
                "Preview",
                style: AppTheme.headingTwo.copyWith(
                  fontSize: 20.0,
                ),
              ),
            ),
            body: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.previewProfileModel != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: ScrollableProfileView(
                          peopleUiModel: state.previewProfileModel!,
                          onLiked: (_) {},
                          onDisLiked: (_) {},
                          onDm: (_) {},
                          onSuperLiked: (_) {},
                        ),
                      )
                    : const Center(
                        child: Text(
                            "Loading the Full profile, just for you, Hang tight"),
                      ),
          );
        },
      ),
    );
  }
}
