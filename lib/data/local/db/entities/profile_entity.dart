import 'package:floor/floor.dart';

@entity
class ProfileEntity {
  @primaryKey
  final int id;
  final String name;
  final String designation;
  final String age;
  final String pronouns;

  ProfileEntity(this.id, this.name, this.designation, this.age, this.pronouns);
}
