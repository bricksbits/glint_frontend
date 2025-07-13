import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';

part 'profile_handling_state.dart';
part 'profile_handling_cubit.freezed.dart';

class ProfileHandlingCubit extends Cubit<ProfileHandlingState> {
  ProfileHandlingCubit() : super(const ProfileHandlingState.initial());
}
