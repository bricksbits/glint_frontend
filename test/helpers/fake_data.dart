import 'dart:io';

import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

class FakeData {
  static RegisterUserRequest createRegisterUserRequest({
    String? username,
    String? email,
    String? password,
    String? gender,
    String? genderPreference,
    String? bio,
    String? height,
    String? education,
    String? occupation,
    String? workoutHabit,
    String? drinkingHabit,
    String? smokingHabit,
    String? relationShipGoals,
    List<String>? interests,
    String? calculatedAge,
    String? phoneNumber,
  }) {
    return RegisterUserRequest(
      NEW_ON_BOARD_USER_ID,
      username ?? 'TestUser',
      email ?? 'test@glinttest.io',
      password ?? 'TestPass123!',
      bio ?? 'I love hiking',
      '2000-01-01 00:00:00',
      height ?? '5.8',
      education ?? 'bachelors',
      occupation ?? 'Engineer',
      gender ?? 'Female',
      genderPreference ?? 'Male',
      workoutHabit ?? 'sometimes',
      drinkingHabit ?? 'occasionally',
      smokingHabit ?? 'nonSmoker',
      relationShipGoals ?? 'Something Casual',
      interests ?? ['Music', 'Travel', 'Fitness', 'Movies', 'Food'],
      calculatedAge ?? '24',
      phoneNumber,
    );
  }

  static PeopleCardModel createPeopleCardModel({
    String? userId,
    String? username,
    String? age,
    String? gender,
    String? bio,
  }) {
    return PeopleCardModel(
      userId: userId ?? '1',
      username: username ?? 'TestPerson',
      age: age ?? '24',
      gender: gender ?? 'Female',
      genderPreference: 'Male',
      interests: ['Music', 'Travel', 'Fitness'],
      lookingFor: 'Something Casual',
      bio: bio ?? 'Test bio',
      profileViews: '10',
      profileLikes: '5',
      pictureUrlList: ['https://example.com/pic1.jpg'],
      distanceAway: '5 km',
      about: {'height': '5.8', 'occupation': 'Engineer'},
      location: 'Bhilai',
      isVerified: false,
      profileTag: '',
      occupation: 'Engineer',
    );
  }

  static List<PeopleCardModel> createPeopleCardList({int count = 5}) {
    return List.generate(
      count,
      (i) => createPeopleCardModel(
        userId: '${i + 1}',
        username: 'User${i + 1}',
        age: '${20 + i}',
      ),
    );
  }
}
