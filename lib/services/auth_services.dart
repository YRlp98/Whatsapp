import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  Future<Map> sendDataToLogin(Map body) async {
    final response =
        await http.post('http://roocket.org/api/login', body: body);
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  static Future<bool> checkApiToken(String apiToken) async {
    final response = await http.get(
        'http://roocket.org/api/user?api_token=${apiToken}',
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
