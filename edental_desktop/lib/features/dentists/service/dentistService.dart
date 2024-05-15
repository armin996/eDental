import 'package:edental_desktop/common/service/baseService.dart';

import '../../../common/models/dentist.dart';

class DentistService extends BaseService<Dentist> {
  DentistService() : super("/dentists");
}
