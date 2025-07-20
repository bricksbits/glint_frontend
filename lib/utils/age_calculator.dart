int calculateAgeFromFormattedString(String formattedDate) {
  try {
    final birthDate = DateTime.parse(formattedDate);
    final today = DateTime.now();

    int age = today.year - birthDate.year;

    // Adjust if birthday hasn't occurred yet this year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  } catch (e) {
    // throw FormatException("Invalid date format. Expected 'yyyy-MM-dd HH:mm:ss'");
    return 0;
  }
}
