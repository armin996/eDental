import 'dart:convert';
import 'dart:developer';
import 'package:edental_desktop/common/models/user.dart';
import 'package:edental_desktop/features/login/provider/authProvider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

class BaseService<T> {
  String? baseUrl = dotenv.dotenv.env["API_URL"];
  final String endpoint;

  BaseService(this.endpoint);

  Future<List<T>?> getAll(
      [String? additionalPath = '', String? searchRequest]) async {
    try {
      var url = Uri.parse('$baseUrl$endpoint$additionalPath');
      var response = await http.get(url, headers: await setHeaders());

      if (response.statusCode == 200) {
        final result = JsonMapper.deserialize<List<T>>(response.body);
        return result ?? [];
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<T> getById(int id,
      [String? additionalPath = '', dynamic searchRequest]) async {
    var url = Uri.parse('$baseUrl$endpoint/$id$additionalPath');
    var response =
        await http.get(url, headers: await setHeaders(searchRequest));

    if (response.statusCode == 200) {
      print(response.body);
      var result = JsonMapper.deserialize<T>(response.body);
      if (result == null) {
        throw Exception('Result null');
      }
      return result;
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<T>?> search(dynamic searchRequest,
      {String? additionalPath = ""}) async {
    var url = Uri.parse('$baseUrl$endpoint$additionalPath');
    var response = await http.post(url,
        body: JsonMapper.serialize(searchRequest),
        headers: await setHeaders(searchRequest));

    if (response.statusCode == 201 || response.statusCode == 200) {
      return JsonMapper.deserialize<List<T>>(response.body);
    } else {
      throw Exception('Failed to create data. Status code: ${response.body}');
    }
  }

  Future<T?> post(dynamic data,
      [String? additionalPath = '', dynamic searchRequest]) async {
    var url = Uri.parse('$baseUrl$endpoint$additionalPath');
    var response = await http.post(url,
        body: JsonMapper.serialize(data),
        headers: await setHeaders(searchRequest));

    if (response.statusCode == 201 || response.statusCode == 200) {
      return JsonMapper.deserialize<T>(response.body);
    } else {
      throw Exception('Failed to create data. Status code: ${response.body}');
    }
  }

  Future<T?> put(int id, dynamic data, [String? additionalPath = '']) async {
    var url = Uri.parse('$baseUrl$endpoint/$id$additionalPath');
    final serializedData = JsonMapper.serialize(data);
    print(serializedData);
    var response = await http.put(url,
        body: serializedData, headers: await setHeaders(null));

    if (response.statusCode == 200) {
      return JsonMapper.deserialize<T>(response.body);
    } else {
      print(response.body);
      throw Exception(
          'Failed to update data. Status code: ${response.statusCode}');
    }
  }

  Future<void> delete(int id,
      [String? additionalPath = '', dynamic searchRequest]) async {
    var url = Uri.parse('$baseUrl$endpoint/$id$additionalPath');
    var response =
        await http.delete(url, headers: await setHeaders(searchRequest));

    if (response.statusCode != 204) {
      throw Exception(
          'Failed to delete data. Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, String>> setHeaders([dynamic searchRequest]) async {
    const localStorage = FlutterSecureStorage();
    final userKey = await localStorage.read(key: "user");
    final user = JsonMapper.deserialize<User>(userKey);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (user != null) {
      headers['Authorization'] =
          'Basic ${base64Encode(utf8.encode('${user.username}:${user.password}'))}';
    }
    return headers;
  }
}
