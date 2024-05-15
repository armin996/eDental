import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../common/models/user.dart';
import '../services/userService.dart';

class UserState {
  List<User>? users = [];
  User? selectedUser;

  UserState({this.users = const [], this.selectedUser});
}

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<UserState>>((ref) {
  return UserNotifier(UserService());
});

class UserNotifier extends StateNotifier<AsyncValue<UserState>> {
  final UserService _service;

  UserNotifier(this._service) : super(const AsyncValue.loading()) {
    loadUsers();
  }

  Future<void> loadUsers({String searchTerm = ""}) async {
    try {
      final users = await _service.getAll(searchTerm);
      state = AsyncValue.data(UserState(users: users));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> searchUser(String searchTerm) async {
    try {
      final req = User();
      req.searchTerm = searchTerm;
      final users = await _service.search(req, additionalPath: "/filtering");
      state = AsyncValue.data(UserState(users: users));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> fetchUserById(int id) async {
    try {
      final user = await _service.getById(id);
      state = AsyncValue.data(
          UserState(selectedUser: user, users: state.value!.users));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> createUser(User user) async {
    try {
      final updatedUser = await _service.post(user);
      state = AsyncValue.data(
          UserState(selectedUser: user, users: state.value!.users));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateUser(User user) async {
    try {
      final updatedUser = await _service.put(user.id!, user);
      state = AsyncValue.data(
          UserState(selectedUser: user, users: state.value!.users));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
