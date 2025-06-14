class RegisterUserRequest {
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String bio;
  final String dob;
  final String height;
  final String education;
  final String occupation;
  final String gender;
  final String genderPreference;
  final String workoutHabit;
  final String drinkingHabit;
  final String smokingHabit;
  final String relationShipGoals;
  final List<String> interests;

  RegisterUserRequest(
    this.username,
    this.email,
    this.password,
    this.phoneNumber,
    this.bio,
    this.dob,
    this.height,
    this.education,
    this.occupation,
    this.gender,
    this.genderPreference,
    this.workoutHabit,
    this.drinkingHabit,
    this.smokingHabit,
    this.relationShipGoals,
    this.interests,
  );

  RegisterUserRequest copyWith({
    String? username,
    String? email,
    String? password,
    String? phoneNumber,
    String? bio,
    String? dob,
    String? height,
    String? education,
    String? occupation,
    String? gender,
    String? genderPreference,
    String? workoutHabit,
    String? drinkingHabit,
    String? smokingHabit,
    String? relationShipGoals,
    List<String>? interests,
  }) {
    return RegisterUserRequest(
      username ?? this.username,
      email ?? this.email,
      password ?? this.password,
      phoneNumber ?? this.phoneNumber,
      bio ?? this.bio,
      dob ?? this.dob,
      height ?? this.height,
      education ?? this.education,
      occupation ?? this.occupation,
      gender ?? this.gender,
      genderPreference ?? this.genderPreference,
      workoutHabit ?? this.workoutHabit,
      drinkingHabit ?? this.drinkingHabit,
      smokingHabit ?? this.smokingHabit,
      relationShipGoals ?? this.relationShipGoals,
      interests ?? this.interests,
    );
  }
}