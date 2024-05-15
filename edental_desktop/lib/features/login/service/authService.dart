import 'dart:convert';
import 'package:edental_desktop/common/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../../../common/service/baseService.dart';

class AuthService extends BaseService<String> {
  AuthService() : super('/auth');

  Future<User?> login(String username, String password) async {
    var url = Uri.parse('$baseUrl$endpoint/login');
    var response = await http.post(url,
        body: jsonEncode({'username': username, 'password': password}),
        headers: await setHeaders());

    if (response.statusCode == 200) {
      User? user = JsonMapper.deserialize<User>(jsonDecode(response.body));
      if (user != null) {
        user.password = password;
      }
      return user;
    } else {
      throw Exception('Login failed. Status code: ${response.statusCode}');
    }
  }
}
