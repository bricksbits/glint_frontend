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
}
