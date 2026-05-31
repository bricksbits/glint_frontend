import 'dart:math';

class TestCredentials {
  static const String loginEmail = 'Batman@glintapp.io';
  static const String loginPassword = '1234567890';

  static String generateEmail() {
    final random = Random().nextInt(99999);
    return 'testuser$random@glinttest.io';
  }

  static String generatePassword() {
    return 'TestPass${Random().nextInt(99999)}!';
  }

  static String generateName() {
    final names = ['TestUser', 'GlintTester', 'QAUser', 'AutoTest'];
    return '${names[Random().nextInt(names.length)]}${Random().nextInt(999)}';
  }

  static String generatePhoneNumber() {
    final prefixes = ['9', '8', '7', '6'];
    final prefix = prefixes[Random().nextInt(prefixes.length)];
    final rest =
        List.generate(9, (_) => Random().nextInt(10).toString()).join();
    return '$prefix$rest';
  }
}
