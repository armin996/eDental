import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../helpers/dateJsonFormatter.dart';

@jsonSerializable
class PaymentSearchRequestDto {
  @JsonProperty(converter: CustomDateTimeConverter(), ignoreIfNull: true)
  DateTime? date;
  int? userId;
  @JsonProperty(ignoreIfNull: true)
  int? treatmentId;
  String client;
  String treatmentName;

  PaymentSearchRequestDto(this.date, this.userId,
      {this.treatmentName = '', this.treatmentId, this.client = ''});
}
