import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental_desktop/common/helpers/reflector.dart';

@jsonSerializable
@reflector
class Report {
  String dentistFullName;
  double averageRate;

  Report(
    this.dentistFullName,
    this.averageRate,
  );
}
