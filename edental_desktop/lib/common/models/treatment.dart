import 'dart:typed_data';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental_desktop/common/helpers/reflector.dart';

@jsonSerializable
@reflector
class Treatment {
  int? id;
  String? name;
  double? price;
  int? timeRequiredInMinutes;
  ByteBuffer? image;
  String? searchTerm;
  Treatment({
    this.id,
    this.name = '',
    this.price = 0.00,
    this.timeRequiredInMinutes = 0,
    this.image,
  });
  Treatment.empty()
      : id = 0,
        name = '',
        price = 0,
        timeRequiredInMinutes = 0,
        searchTerm = '',
        image = null;
}
