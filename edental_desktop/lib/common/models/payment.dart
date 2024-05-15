import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental_desktop/common/helpers/reflector.dart';

import '../helpers/dateJsonFormatter.dart';

@jsonSerializable
@reflector
class Payment {
  int? id;
  @JsonProperty(converter: CustomDateTimeConverter())
  DateTime date;
  double amount;
  int userId;
  int treatmentId;
  String? client;
  String? treatmentName;
  String? dentistName;
  String? paymentIntent;
  Payment(this.date, this.amount, this.userId, this.treatmentId,
      {this.client,
      this.treatmentName,
      this.id,
      this.dentistName,
      this.paymentIntent});
}
