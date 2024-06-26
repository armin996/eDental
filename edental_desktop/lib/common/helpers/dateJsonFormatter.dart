import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../models/gender.dart';
import '../models/role.dart';

class CustomDateTimeConverter implements ICustomConverter<DateTime> {
  const CustomDateTimeConverter() : super();

  @override
  DateTime fromJSON(dynamic jsonValue, DeserializationContext context) {
    return DateTime.parse(jsonValue);
  }

  @override
  dynamic toJSON(DateTime object, SerializationContext context) {
    return object.toIso8601String();
  }
}

class CustomRoleEnumConverter implements ICustomConverter<Role> {
  const CustomRoleEnumConverter() : super();

  @override
  Role fromJSON(jsonValue, DeserializationContext context) {
    return Role.values[jsonValue];
  }

  @override
  toJSON(Role object, SerializationContext context) {
    return object.index;
  }
}

class CustomGenderEnumConverter implements ICustomConverter<Gender> {
  const CustomGenderEnumConverter() : super();

  @override
  Gender fromJSON(jsonValue, DeserializationContext context) {
    if (jsonValue is int) {
      return Gender.values[jsonValue];
    }
    return Gender.values[0];
  }

  @override
  toJSON(Gender object, SerializationContext context) {
    return object.index;
  }
}
