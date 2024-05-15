import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental_desktop/features/login/provider/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../common/models/user.dart';
import '../service/authService.dart';

class AuthScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    // final authService = ref.watch(authProvider);
    final localStorage = ref.watch(localStorageProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                ElevatedButton(
                  onPressed: () async {
                    final currentContext = context;
                    // try {
                    //   final user = await authService.value!.service.login(
                    //       usernameController.text, passwordController.text);
                    //   if (user != null) {
                    //     localStorage.write(
                    //         key: "user", value: JsonMapper.serialize(user));
                    //   }
                    //   // Navigator.pop(currentContext);
                    // } catch (e) {
                    //   ScaffoldMessenger.of(currentContext).showSnackBar(
                    //     SnackBar(content: Text('Login failed: $e')),
                    //   );
                    // }
                    try {
                      // Access the AuthService through the AuthProvider's notifier
                      final user = await ref.read(authProvider.notifier).login(
                          usernameController.text, passwordController.text);
                      if (user != null) {
                        localStorage.write(
                            key: "user", value: JsonMapper.serialize(user));
                      }
                      // Navigator.pop(currentContext);
                    } catch (e) {
                      if (currentContext.mounted) {
                        ScaffoldMessenger.of(currentContext).showSnackBar(
                          SnackBar(content: Text('Login failed: $e')),
                        );
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthState {
  String username;
  String password;
  late AuthService service;
  AuthState(this.username, this.password) {
    service = AuthService();
  }
}

class AuthProvider extends StateNotifier<AsyncValue<AuthState>> {
  final AuthService _service;

  AuthProvider(this._service) : super(const AsyncValue.loading());

  Future<User?> login(String username, String password) async {
    var result = await _service.login(username, password);
    state = AsyncValue.data(AuthState(username, password));
    return result;
  }
}

final authProvider = StateNotifierProvider<AuthProvider, AsyncValue<AuthState>>(
    (ref) => AuthProvider(AuthService()));
