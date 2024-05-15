import 'package:edental_desktop/common/models/payment.dart';
import 'package:edental_desktop/common/service/baseService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentService extends BaseService<Payment> {
  PaymentService() : super("/payments") {
    super.baseUrl = dotenv.env["PAYMENTAPI_URL"];
  }
}
