import 'dart:typed_data';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental_desktop/common/helpers/reflector.dart';

import '../helpers/dateJsonFormatter.dart';

@jsonSerializable
@reflector
class Dentist {
  int? id;
  String firstName;
  String lastName;
  String phone;
  String email;
  String address;
  @JsonProperty(converter: CustomDateTimeConverter())
  DateTime? birthDate;
  int dentistOfficeId;
  Uint8List? image;
  String description;
  bool active;
  String fullName;
  String? searchTerm;

  @override
  bool operator ==(other) => other is Dentist && id == other.id;

  Dentist({
    this.id,
    this.firstName = "",
    this.lastName = "",
    this.phone = "",
    this.email = "",
    this.address = "",
    this.birthDate,
    this.dentistOfficeId = 0,
    this.image,
    this.description = "",
    this.active = false,
    this.fullName = "",
  });
  Dentist.empty()
      : id = null,
        firstName = "",
        lastName = "",
        phone = "",
        email = "",
        address = "",
        birthDate = DateTime.now(),
        dentistOfficeId = 0,
        image = null,
        description = "",
        active = false,
        fullName = "",
        searchTerm = null;
}
