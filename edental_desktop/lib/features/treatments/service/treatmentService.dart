import 'package:edental_desktop/common/service/baseService.dart';

import '../../../common/models/treatment.dart';

class TreatmentService extends BaseService<Treatment> {
  TreatmentService() : super("/treatments");
}
