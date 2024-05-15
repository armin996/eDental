import 'package:edental_desktop/common/models/appointment.dart';
import 'package:edental_desktop/common/service/baseService.dart';

class AppointmentService extends BaseService<Appointment> {
  AppointmentService() : super("/appointments");
}
