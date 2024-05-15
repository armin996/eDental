import 'package:edental_desktop/common/models/user.dart';
import 'package:edental_desktop/common/service/baseService.dart';

class UserService extends BaseService<User> {
  UserService() : super("/users");
}
