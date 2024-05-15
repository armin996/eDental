import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../helpers/dateJsonFormatter.dart';
import '../helpers/reflector.dart';

@jsonSerializable
@reflector
class Appointment {
  int id;
  @JsonProperty(converter: CustomDateTimeConverter())
  DateTime? start;
  @JsonProperty(converter: CustomDateTimeConverter())
  DateTime? end;
  int dentistId;
  int treatmentId;
  int userId;
  String? clientFullName;
  String? dentistFullName;
  String? treatmentName;
  String? searchTerm;
  Appointment.empty()
      : id = 0,
        start = DateTime.now(),
        end = DateTime.now(),
        dentistId = 0,
        dentistFullName = "",
        clientFullName = "",
        treatmentId = 0,
        userId = 0,
        treatmentName = "";
  Appointment(
      {this.id = 0,
      this.start,
      this.end,
      this.dentistId = 0,
      this.treatmentId = 0,
      this.userId = 0,
      this.clientFullName,
      this.dentistFullName,
      this.treatmentName});
}
