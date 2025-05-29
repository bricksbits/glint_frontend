import 'dart:convert';
import 'package:floor/floor.dart';

class StringTypeConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> decode(String databaseValue) {
    return (json.decode(databaseValue) as List<dynamic>).cast<String>();
  }

  @override
  String encode(List<String> value) {
    return json.encode(value);
  }
}
