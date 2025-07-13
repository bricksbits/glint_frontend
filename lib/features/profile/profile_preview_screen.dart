import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/components/people/scrollable_profile_view.dart';
import 'package:glint_frontend/features/profile/bloc/profile_handling_cubit.dart';

class ProfilePreviewScreen extends StatelessWidget {
  const ProfilePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileHandlingCubit(),
      child: BlocBuilder<ProfileHandlingCubit, ProfileHandlingState>(
        builder: (context, state) {
          return Scaffold(
            body: ScrollableProfileView(
              peopleUiModel: state.previewProfileModel!,
              onLiked: (_) {},
              onDisLiked: (_) {},
              onDm: (_) {},
              onSuperLiked: (_) {},
            ),
          );
        },
      ),
    );
  }
}
