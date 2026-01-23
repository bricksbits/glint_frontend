double? toDouble(dynamic value) {
  try {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  } catch (e) {
    return null;
  }
}
