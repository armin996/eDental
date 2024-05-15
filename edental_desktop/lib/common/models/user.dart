import 'dart:typed_data';
import 'package:edental_desktop/common/helpers/reflector.dart';
import '../models/role.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../models/gender.dart';
import '../helpers/dateJsonFormatter.dart';

@jsonSerializable
@reflector
class User {
  int? id;
  String firstName;
  String lastName;
  String username;
  String? phone;
  String email;
  String? address;
  String? password;
  String? passwordConfirm;
  @JsonProperty(converter: CustomRoleEnumConverter())
  Role? role;
  @JsonProperty(converter: CustomGenderEnumConverter())
  Gender? gender;
  Uint8List? image;
  String get fullName => '$firstName $lastName';
  bool isNotificationEnabled;
  String? searchTerm;
  User(
      {this.firstName = '',
      this.lastName = '',
      this.username = '',
      this.phone = '000000000',
      this.email = '',
      this.address,
      this.password,
      this.passwordConfirm,
      this.role = Role.Client,
      this.gender = Gender.Male,
      this.image,
      this.id,
      this.isNotificationEnabled = false,
      this.searchTerm = ''});
}
