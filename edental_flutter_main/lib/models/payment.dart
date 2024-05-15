import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../helpers/dateJsonFormatter.dart';

@jsonSerializable
class Payment {
  int? id;
  @JsonProperty(converter: CustomDateTimeConverter())
  DateTime date;
  double amount;
  int userId;
  int treatmentId;
  int appointmentId;
  String? client;
  String? treatmentName;
  String? dentistName;
  String? paymentIntent;
  Payment(
      this.date, this.amount, this.userId, this.treatmentId, this.appointmentId,
      {this.client,
      this.treatmentName,
      this.id,
      this.dentistName,
      this.paymentIntent});
}
