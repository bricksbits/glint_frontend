import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/background/info/user_info_repo.dart';
import 'package:injectable/injectable.dart';

part 'user_info_manager_state.dart';
part 'user_info_manager_cubit.freezed.dart';

@LazySingleton()
class UserInfoManagerCubit extends Cubit<UserInfoManagerState> {

  final userInfoRepo = getIt.get<UserInfoRepo>();

  UserInfoManagerCubit() : super(const UserInfoManagerState.initial());

  Future<void> updateTheFcmTokenToServer(String fcmToken) async {
    await userInfoRepo.updateFcmToken(fcmToken);
  }

}
