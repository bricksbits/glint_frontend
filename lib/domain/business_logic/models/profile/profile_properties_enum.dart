enum WorkoutOptions {
  gymFreak,
  homeExercise,
  often,
  sometimes,
  never,
}

enum DrinkingHabit {
  never,
  occasionally,
  socially,
  frequently,
  tryingToQuit,
}

enum Education {
  graduate,
  postGraduate,
  doctorate,
  diploma,
  noEducation,
}

enum SmokingHabit { nonSmoker, occasional, social, smoker, toQuit }

extension EnumExtension on Enum {
  /// Converts an enum value (e.g., 'WorkoutOptions.gymFreak') into a readable
  /// Title Case string (e.g., 'Gym Freak').
  String toDisplayString() {
    // 1. Get the name string (e.g., 'gymFreak' or 'tryingToQuit')
    final name = toString().split('.').last;

    // 2. Insert spaces before capital letters (for camelCase)
    String spaced =
        name.replaceAllMapped(RegExp(r'([A-Z])'), (Match m) => ' ${m[1]!}');

    // 3. Capitalize the first letter of each word to achieve Title Case
    return spaced
        .split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ')
        .trim();
  }

  /// Returns the enum name as a single, lower-cased string, ready for database storage.
  /// (e.g., 'homeexercise' or 'gymfreak').
  String toLowerString() {
    return toString().split('.').last.toLowerCase().replaceAll(' ', '');
  }
}

T getEnumFromString<T extends Enum>(
    String? input, List<T> values, T defaultValue) {
  // Normalize the input string: lower-cased and removes all non-alphanumeric characters (including spaces).

  if(input == null){
    return defaultValue;
  }

  final normalizedInput =
      input.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

  for (final value in values) {
    // Get the enum's internal name (e.g., 'nonSmoker') and normalize it.
    final enumName = value.toString().split('.').last;
    final normalizedEnumName =
        enumName.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

    if (normalizedInput == normalizedEnumName) {
      return value;
    }
  }

  return defaultValue;
}
