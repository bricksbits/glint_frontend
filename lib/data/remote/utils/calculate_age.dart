import 'package:intl/intl.dart';

int calculateAge(String birthDateStr) {
  DateTime birthDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(birthDateStr);
  DateTime today = DateTime.now();

  int age = today.year - birthDate.year;

  // If birthday hasn't occurred yet this year, subtract 1
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age;
}